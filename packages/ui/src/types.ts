/**
 * The type of a navigation entry.
 */
export type NavItem =
  | {
      label: string;
      href: string;
    }
  | {
      label: string;
      dropdown: NavItem[];
    };
