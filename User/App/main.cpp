/**
 * @file main.cpp
 * @brief MSPM0G3507 FreeRTOS 项目模板
 *
 * 基础结构：
 *   - 1ms 控制任务（编码器 + 传感器轮询 + PID）
 *   - 50ms 显示/通信任务
 *   - 调试串口 UART0: PA10(TX) PA11(RX) @115200
 *
 * 从 m0template 克隆后，在此文件添加业务逻辑。
 */

#include "main.hpp"
#include "bsp_gpio.h"
#include "FreeRTOS.h"
#include "task.h"

/* ================================================================
 *  任务句柄
 * ================================================================ */
static TaskHandle_t g_ctrl_task;
static TaskHandle_t g_disp_task;

/* ================================================================
 *  控制任务 — 1ms 周期
 * ================================================================ */
static void vControlTask(void *pvParams)
{
    TickType_t xLastWakeTime = xTaskGetTickCount();

    while (1)
    {
        /* TODO: 添加传感器读取、编码器读数、PID 计算 */

        vTaskDelayUntil(&xLastWakeTime, pdMS_TO_TICKS(1));
    }
}

/* ================================================================
 *  显示/通信任务 — 50ms 周期
 * ================================================================ */
static void vDisplayTask(void *pvParams)
{
    TickType_t xLastWakeTime = xTaskGetTickCount();

    while (1)
    {
        /* TODO: 添加显示刷新、串口输出、状态机 */

        vTaskDelayUntil(&xLastWakeTime, pdMS_TO_TICKS(50));
    }
}

/* ================================================================
 *  主函数
 * ================================================================ */
int main()
{
    SYSCFG_DL_init();

    /* TODO: 初始化外设 */
    // motor_init();
    // mt6816_init();

    bsp_uart_printf("=== MSPM0 FreeRTOS Template ===\r\n");

    xTaskCreate(vControlTask, "Ctrl", 256, NULL, 3, &g_ctrl_task);
    xTaskCreate(vDisplayTask, "Disp", 512, NULL, 2, &g_disp_task);

    vTaskStartScheduler();

    while (1) {}
}
