public func example(title: String, _ complition: () -> ()) {
    print(title)
    complition()
    print()
}
