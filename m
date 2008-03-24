Subject: Re: Removing DAC.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: cinthya aranguren <cinthya.aranguren@gmail.com>
Cc: casey@schaufler-ca.com, selinux@tycho.nsa.gov
In-Reply-To: <50771f160803241029r41c75d93r6babbd5d911a305a@mail.gmail.com>
References: <613578.78683.qm@web36601.mail.mud.yahoo.com>
	 <404587.40497.qm@web36614.mail.mud.yahoo.com>
	 <50771f160803241029r41c75d93r6babbd5d911a305a@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 24 Mar 2008 13:45:13 -0400
Message-Id: <1206380713.3302.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-03-24 at 14:29 -0300, cinthya aranguren wrote:
> On Sun, Mar 23, 2008 at 2:40 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> >  --- Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> >  >
> >  > --- cinthya aranguren <cinthya.aranguren@gmail.com> wrote:
> >  >
> >  > > Hi,
> >  > >
> >  > > Is there any way to avoid o remove DAC controls ? I'd like to have only one
> >  > > security scheme in my system. I mean a pure SElinux system. not DAC + MAC.
> >  > > only MAC.
> >  >
> >  > No.
> >  >
> >  > Well, not today.
> >
> >  I will add that if every process runs with CAP_DAC_OVERRIDE set
> >  you can approach "no DAC", but I think you would probably have
> >  to dig very deeply into the behavior of security cognizant
> >  applications (sendmail comes to mind) and make sure that they
> >  aren't explictly dropping that capability. I will let those
> >  who work more closely with SELinux policy than I do describe
> >  how capabilities possessed are related to an SELinux policy
> >  and how that might impact the behavior of SELinux. You should
> >  also note that SELinux takes what are traditionally DAC
> >  attributes into account when making decisions and that if you
> >  use MCS you are using a DAC mechanism within SELinux. I'm not
> >  saying that's bad, just that it's there.
> >
> 
> This is a good point. I will experiment with CAP_DAC_OVERRIDE.
> but .. why SELinux take DAC attributes into account when making
> decisions ?? this does not violate the separation of "policy" from
> "Enforcement" ??

SELinux does not use the DAC attributes (uid, gid, mode bits) as part of
its decision.

SELinux does however control the use of capabilities/privileges in
accordance with its policy.  And it does have a notion of user identity
in its security context, although that is separately managed and is
usually used just as a "role set" construct in modern SELinux (e.g.
staff_u authorized for staff_r and sysadm_r).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
