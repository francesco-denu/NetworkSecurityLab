<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Calculator</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f4f8;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding-top: 50px;
            color: #333;
        }
        .calculator {
            background: white;
            padding: 25px 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.12);
            width: 400px;
        }
        h2 {
            text-align: center;
            color: #005f73;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        input[type="text"] {
            flex-grow: 1;
            font-size: 1.1rem;
            padding: 10px 15px;
            border: 2px solid #94d2bd;
            border-radius: 8px;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus {
            border-color: #0a9396;
            outline: none;
        }
        button {
            background-color: #0a9396;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #007f7f;
        }
        .result {
            font-weight: 700;
            font-size: 1.6rem;
            color: #001219;
            min-height: 40px;
            text-align: center;
            border: 2px solid #94d2bd;
            border-radius: 8px;
            padding: 12px 10px;
            background-color: #e0fbfc;
            user-select: text;
        }
        .footer {
            margin-top: 25px;
            font-size: 0.9rem;
            color: #555;
            text-align: center;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="calculator">
        <h2>Simple Calculator</h2>
        <form method="GET" action="">
            <input 
                type="text" 
                name="expr" 
                placeholder="Enter expression, e.g. 2+3*4" 
                autocomplete="off"
                value="<?php echo isset($_GET['expr']) ? htmlspecialchars($_GET['expr']) : ''; ?>"
            >
            <button type="submit">Calculate</button>
        </form>

        <div class="result" aria-live="polite">
            <?php
            if (isset($_GET['expr'])) {
                $expr = $_GET['expr'];
                try {
                    // Vulnerable eval on raw user input (dangerous!)
                    $result = eval("return $expr;");
                    echo $result;
                } catch (Throwable $e) {
                    echo "Error in expression!";
                }
            } else {
                echo "Result will appear here";
            }
            ?>
        </div>

    </div>
</body>
</html>
