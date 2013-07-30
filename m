Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6UIQQK5030667
	for <selinux@tycho.nsa.gov>; Tue, 30 Jul 2013 14:26:27 -0400
References: <CABhRnsXoNT5JBbMjd36w5o3Q4KEJ51CqHmL9FJihC-H5yrdqFg@mail.gmail.com>
Message-ID: <1375208781.1906.YahooMailNeo@web87903.mail.ir2.yahoo.com>
Date: Tue, 30 Jul 2013 19:26:21 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Building the Base Policy Module
To: Thomas COUDRAY <amanone@gmail.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <CABhRnsXoNT5JBbMjd36w5o3Q4KEJ51CqHmL9FJihC-H5yrdqFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I thought I deleted that page a few months ago as it is out of date (although the principles are the same).

You can download the new tarball from: http://freetechbooks.com/the-selinux-notebook-the-foundations-t785.html

In the directory: basic-selinux-policy/modular-base-policy there is a Makefile that goes through the steps. I've just built this on Fedora 17 and it built ok. I've not tested it for awhile but see no reason why it should not work. Just remember it is a very basic policy and just really allows everything.

The updated notes to build the various modules are in: basic-selinux-policy/message-filter/The SELinux Notebook - Building The Sample Policy.pdf

If you do find errors please let me know as I like things to work and will fix any problems.


Richard



----- Original Message -----
From: Thomas COUDRAY <amanone@gmail.com>
To: selinux@tycho.nsa.gov
Cc: 
Sent: Tuesday, 30 July 2013, 18:45
Subject: Building the Base Policy Module

I followed the SELinux documentation for building the base policy module.

When I use checkmodule (checkmodule -o base.mod base.conf), I get this error.

# checkmodule -o base.mod base.conf
checkmodule:  loading policy configuration from base.conf
base.conf:1014:ERROR 'unknown role unconfined_r' at token ';' on line 1014:
role unconfined_r types { unconfined_t };
# The only role defined for this policy:
checkmodule:  error(s) encountered while parsing configuration

Also the base.fc, dbus_context,  file, is missing.

[1]: http://selinuxproject.org/page/Building_a_Basic_Policy#Building_the_Base_Policy_Module

Thomas Coudray

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
