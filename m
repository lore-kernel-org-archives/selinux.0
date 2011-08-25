Subject: Re: v0 Separate tunables from booleans
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: qingtao.cao@windriver.com, Eric Paris <eparis@parisplace.org>,
        cpebenito@tresys.com, slawrence@tresys.com, selinux@tycho.nsa.gov
Date: Thu, 25 Aug 2011 09:35:47 -0400
In-Reply-To: <4E564860.2090502@redhat.com>
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com>
	 <CACLa4pvMmx32JpX=vzOb8TvEqJ7HqTBVK=PNTFQjkiF924sMjA@mail.gmail.com>
	 <4E55E8E7.1050804@windriver.com> <4E564860.2090502@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314279347.11929.6.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-08-25 at 09:04 -0400, Daniel J Walsh wrote:
> On 08/25/2011 02:17 AM, Harry Ciao wrote:
> > Hi Eric,
> > 
> > Eric Paris 写道:
> >> On Tue, Aug 23, 2011 at 6:08 AM, Harry Ciao
> >> <qingtao.cao@windriver.com> wrote:
> >> 
> >> 
> >>> With this patchset, the size of policy.X would drop
> >>> significantly from 600+k down to 322+k bytes(since most of
> >>> tunables are default to false, and there is no else branch of
> >>> most conditionals).
> >>> 
> >> 
> >> I should point out that I think you're off by one order of
> >> magnitude. You went from a 6M policy to a 3.2M policy.  But
> >> still.
> >> 
> >> I decided to do a little playing with this yesterday in Fedora
> >> policy (where Dan already DRASTICALLY reduced the policy size by
> >> changing from type sets with removal to using all attributes.  My
> >> numbers weren't quite as impressive as yours (and I'm not certain
> >> I did one thing correctly)
> >> 
> >> Pre Patch: 2148552 bytes    89383 allow rules    193 booleans 
> >> Post Patch (no policy changes) 2166328 bytes    89383 allow rules
> >> 193 booleans Post Patch WITH policy changes 2031150 bytes
> >> 79685 allow rules    4 booleans
> >> 
> >> So our policy grows 0.8% with only the tools change.  Our policy 
> >> shrinks 5.5% with this change.  So it certainly doesn't look like
> >> bad news.
> >> 
> >> 
> >> 
> > No problem. I am using refpolicy from tresys tree and I have
> > applied my test patch to introduce a new keyword of "tunable" and
> > change tunable_policy() to use this tunable keyword rather than the
> > current "bool" keyword. Since your number of booleans has jumped
> > from 193 down to 4, you must have applied this patch correctly :-)
> > 
> > Since most tunables declared by tunable_policy() would default to
> > false and most of these tunable_policy() just has one if branch,
> > then in practice none rules would ever be expanded and written to
> > raw policy for them, that's why I have witnessed a significant drop
> > from 6M to 3.22M.
> > 
> > So I could only guess in Fedora policy perhaps most tunables
> > default to true, or many tunable conditionals have two branches,
> > then the logically true branch would be expanded as normal. By
> > whatever, the size of policy.X would decrease when all disabled
> > branch of rules are discarded.
> > 
> 
> The Fedora policy has removed all calls that do stuff like
> 
> allow XYZ_t { file_type -shadow_t }:file read;
> 
> Which generates hundreds/thousands of rules when run though the M4
> Macro, since it writes a rule for each file_type except the shadow_t.
>  Anywhere in policy that we use this construct has to be reworked and
> this shrunk the policy by 90%.  Your enhancement just adds another 5%
> reduction after this change.  I sent a patch to refpolicy yesterday to
> fix the coreutils interfaces that we doing something like this.
> 

I saw your patch removing -port_t and notice that it is in rawhide, but
I don't see anything in rawhide removing -shadow_t. Will that be
appearing soon? It will make translating Refpolicy to CIL much easier.
> 
> >> I did have one problem with my testing however. 
> >> 0002-user_ping-is-a-tunable-use-tunable_policy-for-it.patch
> >> doesn't apply to Fedora.  I tried to fix it up by hand.  We
> >> actually have both of the following lines inside that if
> >> (user_ping) netutils_domtrans_ping($1) allow $1 ping_t:process {
> >> signal sigkill };
> >> 
> >> I turned that into: tunable_policy(`user_ping',` 
> >> netutils_domtrans_traceroute($1) allow $1 traceroute_t:process {
> >> signal sigkill }; ')
> >> 
> >> But that resulted in an error which I didn't bother to figure
> >> out. Maybe you can tell me what it is?
> >> 
> >> 
> This is happening because sepolgen does not understand the new syntax.
>  It can be ignored until the new syntax is agreed upon, then sepolgen
> will need to be updated.
> > Sorry I have no idea what this error is. There is no "allow $1 
> > ping_t/traceroute_t:process ..." rules in these two interface in
> > tresys refpolicy, but after added them exactly as yours above still
> > no error happens on my side.
> > 
> > Or could you pass me your patch to netutils.if after you've adopted
> > my original patch manually?
> > 
> > Thanks, Harry
> > 
> > 
> >> /usr/share/selinux/devel/include/system/modutils.if: Syntax error
> >> on line 181095 ` [type=TICK] 
> >> /usr/share/selinux/devel/include/system/modutils.if: Syntax error
> >> on line 181097 ' [type=SQUOTE]
> >> 
> >> It's also very possible that it comes from sepolgen-ifgen and it
> >> is part of the fedora-ism that is setroubleshoot.....
> >> 
> >> -Eric
> >> 
> >> 
> > 
> > 
> > -- This message was distributed to subscribers of the selinux
> > mailing list. If you no longer wish to subscribe, send mail to
> > majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> > without quotes as the message.
> > 
> > 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
