From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Morris <jmorris@namei.org>
Subject: Re: can not boot with strict policy
Date: Thu, 26 Apr 2007 17:45:42 +1100
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Ken YANG <spng.yang@gmail.com>,
        SELinux List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
References: <462CA1F0.2000400@gmail.com> <1177340494.24282.28.camel@moss-spartans.epoch.ncsc.mil> <Line.LNX.4.64.0704231341100.3793@d.namei>
In-Reply-To: <Line.LNX.4.64.0704231341100.3793@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704261645.50811.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 24 April 2007 03:42, James Morris <jmorris@namei.org> wrote:
> > Boot with "enforcing=0 single" to come up permissive into single-user
> > mode, then run /sbin/fixfiles relabel -F to forcible relabel everything,
> > then reboot.
>
> I wonder if we could automate this, so that the autorelabel is also run
> on boot if you switch between different types of policy.

There are a few ways of doing this.  For my Kickstart configuration of MLS 
systems and Play machines I used to create an /etc/init.d script that would 
put the machine in enforcing mode and configure grub with enforcing=1 and 
then put enforcing=0 on the grub command-line before the final reboot of the 
install.

For a more general solution you might want to have /sbin/init search 
for /.changing-policy-type as a reason to boot in permissive mode.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
