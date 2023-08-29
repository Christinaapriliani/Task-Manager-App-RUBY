class TaskManager
  def initialize
    @tasks = []
    load_tasks
  end

  def load_tasks
    if File.exist?('tasks.txt')
      @tasks = File.readlines('tasks.txt').map(&:chomp)
    end
  end

  def save_tasks
    File.open('tasks.txt', 'w') do |file|
      @tasks.each { |task| file.puts(task) }
    end
  end

  def add_task(task)
    @tasks << task
    save_tasks
  end

  def delete_task(task_number)
    if task_number >= 1 && task_number <= @tasks.length
      @tasks.delete_at(task_number - 1)
      save_tasks
    end
  end

  def display_tasks
    @tasks.each_with_index do |task, index|
      puts "#{index + 1}. #{task}"
    end
  end

  def start
    loop do
      puts "\nTask Manager App\n"
      display_tasks
      puts "\nWhat would you like to do? (add/delete/quit)"
      action = gets.chomp.downcase

      case action
      when 'add'
        print 'Enter a new task: '
        task = gets.chomp
        add_task(task)
      when 'delete'
        print 'Enter the task number to delete: '
        task_number = gets.chomp.to_i
        delete_task(task_number)
      when 'quit'
        break
      else
        puts 'Invalid action. Please choose add, delete, or quit.'
      end
    end
  end
end

task_manager = TaskManager.new
task_manager.start
