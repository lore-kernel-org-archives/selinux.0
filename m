Subject: Re: SELinux on Wheezy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: cjac@colliertech.org
Cc: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
In-Reply-To: <1328502407.14110.7074.camel@calcifer>
References: <1328502407.14110.7074.camel@calcifer>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 06 Feb 2012 10:39:22 -0500
Message-ID: <1328542762.9705.62.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2012-02-05 at 20:26 -0800, C.J. Adams-Collier KF7BMP wrote:
> Hey folks,
> 
> I brought up a wheezy install on an alternate lvm root a couple of weeks
> ago.  I turned SELinux on shortly thereafter.  I think I updated my
> kernel, and now X won't start.  Could someone look at these logs with me
> and help figure out what's going on?  Something showed up during boot
> that said something about updating labels, but I didn't capture it.
> Where should I look to find these boot logs, do you think?
> 
> http://www.colliertech.org/federal/nsa/selinux-20120205T2023PST.log

Are there any avc denials?  If running auditd, then use ausearch -m AVC.
Otherwise grep for avc: in your messages file or dmesg output.

What does sestatus report?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
