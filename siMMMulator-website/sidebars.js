/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 * @format
 */

/**
 * Creating a sidebar enables you to:
 - create an ordered group of docs
 - render a sidebar for each doc of that group
 - provide next/previous navigation

 The sidebars can be generated from the filesystem, or explicitly defined here.

 Create as many sidebars as you want.
 */

 module.exports = {
  mySidebar: [
    // Normal syntax:

    {
      type: 'doc',
      id: 'about_simmmulator', // document ID
      label: 'About siMMMulator', // sidebar label
    },

    {
      type: 'category',
      label: 'Using siMMMulator',
      collapsible: true,
      collapsed: false,
      items: ['set_up', 'step_by_step_guide', 'demo_code']
    },

    {
      type: 'category',
      label: 'FAQ and Support',
      collapsible: true,
      collapsed: false,
      items: [
        'FAQ and Support',
        {
          type: 'link',
          label: 'Facebook Group',
          href: 'https://www.facebook.com/groups/1709945532706010/',
        },
        {
          type: 'link',
          label: 'Github',
          href: 'https://github.com/facebookexperimental/siMMMulator',
        },
      ],
    },

  ],
};
