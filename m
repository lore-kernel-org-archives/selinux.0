Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4AK2tPt027811
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2012 16:02:55 -0400
Received: by qcsk26 with SMTP id k26so1674337qcs.12
        for <selinux@tycho.nsa.gov>; Thu, 10 May 2012 13:02:55 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: RFC: packet checks always on option
Date: Thu, 10 May 2012 16:02:09 -0400
Message-ID: <1540303.QUZeuyPSRI@sifl>
In-Reply-To: <4FA95098.1050201@tresys.com>
References: <4FA95098.1050201@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, May 08, 2012 12:58:00 PM Christopher J. PeBenito wrote:
> I recently became aware that the packet checks are now disabled when there
> are no SECMARK rules ...
>
> ... this behavior is "allow by default": the opposite of what SELinux stands
> for.  SELinux doesn't stop file checks if you mount an xattr filesystem that
> has no labels.  High assurance systems would actually want the old behavior
> so that networking would be denied if:
> 
> * iptables rules fail to load
> * iptables rules maliciously flushed, e.g. by compromised domain that has
> net_admin

Ever since secmark was introduced it has required users/admins to ensure, via 
a secondary mechanism not contained within the SELinux policy, that the 
netfilter/iptables configuration was both correctly matched to the policy and 
that is was not tampered with, either maliciously or accidentally.  Failure to 
do this verification and correctly configure netfilter/iptables could result 
in the mis-labeling of network traffic via the secmark label.

This applies to both the current behavior and the "old" behavior.

Simply going back to always applying the per-packet secmark access controls 
does nothing to solve the problem of ensuring correctness.  This is my main 
problem with your argument.

> * during boot and shutdown you can guarantee no network access

You can do this through a variety of other mechanisms that have nothing to do 
with secmark labels.
 
> I think this behavior should be restored ...

I disagree.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
