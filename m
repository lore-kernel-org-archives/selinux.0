Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l699dxv6002923
	for <selinux@tycho.nsa.gov>; Mon, 9 Jul 2007 05:39:59 -0400
Received: from web34802.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l699dwC5027116
	for <selinux@tycho.nsa.gov>; Mon, 9 Jul 2007 09:39:58 GMT
Date: Mon, 9 Jul 2007 10:39:43 +0100 (BST)
From: Louis Lam <lshoujun@yahoo.com>
Subject: Re: Newbie: Using SELINUX to contain vmware
To: Ken YANG <spng.yang@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <468E2E84.3000105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <275385.80421.qm@web34802.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I was trying this on a Centos05 system, assuming that it was built upon the same sources as RHEL5:

I've installed the selinux-policy-devel rpm. can't find the vmware.pp module. Source wise there is
only a vmware.if file. No vmware.te or vmware.fc. I'm not sure why these two files are not
included  since all three are needed to make the vmware.pp module. Perhaps someone who is
experienced on RHEL5/CENTOS can shed light on the reason why only the vmware.if is included?

Then I read somewhere that policygentool can be used to generate all the three files
(.if,.te,.fc). I'll try this approach too.

BUT in this case where I were to try the method that Ken suggested below (Thanks Ken!). I'm using
the files from "http://oss.tresys.com/repos/refpolicy/trunk" .In this case i already have all the
three files, I could just use make on them to generate the pp right?

But when i try to do make I get the following errors that I don't seem to understand:

make -f /usr/share/selinux/devel/Makefile
vmware.if:168: Error: duplicate definition of vmware_per_role_template(). Original definition on
16
9.
vmware.if:186: Error: duplicate definition of vmware_read_system_config(). Original definition on
1
87.
vmware.if:204: Error: duplicate definition of vmware_append_system_config(). Original definition
on
 205.
Compiling targeted vmware module
/usr/bin/checkmodule:  loading policy configuration from tmp/vmware.tmp
vmware.te:38:ERROR 'syntax error' at token 'manage_files_pattern' on line 78147:
# cjp: the ro and rw files should be split up
manage_files_pattern(vmware_host_t,vmware_sys_conf_t,vmware_sys_conf_t)
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make: *** [tmp/vmware.mod] Error 1

Not very sure what is going on here, pl help. I'm thinking there may be some conflict between the
vmware.if from the selinux-policy-devel rpm and the one downloaded from
http://oss.tresys.com/repos/refpolicy/trunk

Thanks in advance.
Louis



--- Ken YANG <spng.yang@gmail.com> wrote:

> Louis Lam wrote:
> > Hi Ken,
> > 
> > Thank you for your replies. I'll try that out.
> > 
> > About my system. My target is to use RHEL 5. But i have no restrictions to use FC either.
> > 
> > Pardon my ignorance, btw, what do you mean by the "upstream" vmware policy? Where may I be
> able to
> > get it?
> 
> IMHO, "upstream" means reference policy svn trunk, you can get it through:
> 
> svn co http://oss.tresys.com/repos/refpolicy/trunk refpolicy
> 
> similarly, you can also user vmware[.te, .fc, .if] in EL5 policy source.
> 
> 
> > 
> > Thanks in advance,
> > Louis
> > 
> > 
> > --- Ken YANG <spng.yang@gmail.com> wrote:
> > 
> >> Louis Lam wrote:
> >>> Hi All,
> >>>
> >>> I'm trying to use SELINUX to contain vmware. I'm a newbie to the "newer" modules based
> SELINUX
> >>> under RHEL5/CenTOS5. I can see that there is a vmware.if defined but don't know how to build
> >> the
> >>> module vmware.pp. Not even sure if i'm on the correct track doing this. pl advice.
> >> what is your system? in fedora, there is vmware module at default:
> >>
> >> -(:17:48:$)-> sudo semodule -l|grep vmware
> >> vmware  1.1.1
> >>
> >> if your policy have not vmware module, you can build it from policy source:
> >>
> >> # cd "dir containg your vmware source policy"
> >> (vmware.fc, vmware.te, vmware.if)
> >>
> >> # make -f /usr/share/selinux/devel/Makefile
> >> (you must install selinux-policy-devel package first)
> >>
> >> # semodule -i vmware.pp
> >> # restorecon -R -v "vmware relative directories"
> >>
> >>
> >>> I'm trying to use SELINUX to contain the free vmplayer 2.0.0 downloadable from vmware site.
> >> Has
> >>> anyone succeeded in doing so? Maybe can point me to the right resources. Thanks.
> >> through upstream vmware policy, i can run vmware-workstation 6 smoothly,
> >> so i think vmplayer 2.0.0 is also ok.
> >>
> >>
> >>> Thanks in Advance,
> >>> Louis
> >>>
> >>> Send instant messages to your online friends http://uk.messenger.yahoo.com 
> >>>
> >>> --
> >>> This message was distributed to subscribers of the selinux mailing list.
> >>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> >>> the words "unsubscribe selinux" without quotes as the message.
> >>>
> >>
> >> --
> >> This message was distributed to subscribers of the selinux mailing list.
> >> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> >> the words "unsubscribe selinux" without quotes as the message.
> >>
> > 
> > 
> > Send instant messages to your online friends http://uk.messenger.yahoo.com 
> > 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


Send instant messages to your online friends http://uk.messenger.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
