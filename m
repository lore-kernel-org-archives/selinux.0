Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k81JQdXs020617
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 15:26:40 -0400
Received: from nf-out-f131.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k81JQJIk012981
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 19:26:19 GMT
Received: by nf-out-f131.google.com with SMTP id o54so63762nfa
        for <selinux@tycho.nsa.gov>; Fri, 01 Sep 2006 12:26:38 -0700 (PDT)
Message-ID: <707766130609011226k1ff10e8fxe7db5e8784ef831d@mail.gmail.com>
Date: Fri, 1 Sep 2006 21:26:36 +0200
From: "L.M.H." <lmh@info-pull.com>
To: selinux@tycho.nsa.gov, apparmor-general@forge.novell.com,
        netfilter-announce@lists.netfilter.org
Subject: [ANN] visreport-0.2: log data visualization for NSA SELinux and Netfilter Iptables
Cc: apparmor-dev@forge.novell.com, apparmor-announce@forge.novell.com,
        opensuse@opensuse.org, fedora-selinux-list@redhat.com,
        netfilter@lists.netfilter.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Info-pull.com has released visreport-0.2

About visreport
-------------

Visreport is a data visualization tool for multiple formats of log
records. Currently it has
support for AppArmor, NSA SELinux -avc denials- and Netfilter Iptables logs.

Thanks to the Gruff library and the RMagick API available for the Ruby
language, it's
capable of generating visualizations with anti-aliasing and nice design.

It can generate reports in (X)HTML language using ERB (embedded ruby)
within simple
templates. Thus, everything is fully customizable.

It's well documented and works on any platform supported by Ruby and
the required dependencies (ex. Mac OS X, GNU/Linux, Microsoft
Windows).

The code is cleanly formatted and organized, allowing easy
implementation for support
of new log formats.

Release notes
-------------

The code is available as usual within the Subversion repository:

     svn co svn://projects.info-pull.com/visreport

URLs
----

Homepage: http://projects.info-pull.com/projects/visreport
Gallery: http://www.info-pull.com/image/tid/4
Forums: http://www.info-pull.com/forum/5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
