Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6H6wIT6032685
 for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2015 02:58:18 -0400
Received: by wgmn9 with SMTP id n9so74895461wgm.0
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 23:58:05 -0700 (PDT)
Date: Fri, 17 Jul 2015 10:58:02 +0400
From: Jason Zaman <jason@perfinion.com>
To: Robert Kuska <rkuska@redhat.com>
Subject: Re: Python3 Support for Sepolgen module
Message-ID: <20150717065802.GA12312@meriadoc.Home>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
 <439836082.34025817.1437047775259.JavaMail.zimbra@redhat.com>
 <20150716221605.GB28538@meriadoc.Home>
 <839397810.34677360.1437115148590.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <839397810.34677360.1437115148590.JavaMail.zimbra@redhat.com>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 17, 2015 at 02:39:08AM -0400, Robert Kuska wrote:
> > How much progress do you have on porting policycoreutils? There are a
> > lot of mismatched tabs/spaces in it which are causing problems in
> > python3 and I havent gotten further yet. I started looking at fixing up
> > these but if you've already done it then there is no point in me
> > re-doing it.
> 
> Sepolgen should be done.
> 
> There are still scripts which we already got ported and will be here for a review soon:
> > $ rpm -ql policycoreutils-python | grep bin                                        [±master ●▴]
> /usr/bin/audit2allow
> /usr/bin/audit2why
> /usr/bin/chcat
> /usr/bin/sandbox
> /usr/bin/semodule_package
> /usr/sbin/semanage
> 
> Am I missing something?

When I tried running semanage with python3, it needed a few more too:
/usr/lib64/python*/site-packages/sepolicy/*
/usr/lib64/python*/site-packages/seobject.py

I look forward to testing the rest of your patches :)
-- Jason
