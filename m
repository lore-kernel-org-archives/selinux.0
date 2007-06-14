Date: Thu, 14 Jun 2007 13:28:36 -0400
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
 capabilities
From: Chad Sellers <csellers@tresys.com>
To: James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <C296F304.23443%csellers@tresys.com>
In-Reply-To: <Line.LNX.4.64.0706141250100.18953@localhost.localdomain>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 6/14/07 12:52 PM, "James Morris" <jmorris@namei.org> wrote:

> On Thu, 14 Jun 2007, Stephen Smalley wrote:
> 
>> + if (selinux_enforcing) {
>> +  rc = avc_has_perm_noaudit(sid, sid, SECCLASS_CAP_OVERRIDE,
>> +       CAP_TO_MASK(cap), AVC_STRICT, NULL);
>> +  if (!rc)
>> +   goto out;
> 
> I wonder if this will break applications now -- if their suid bit is
> removed, and SELinux authoritatively grants capabilities, they'll just
> stop working in permissive mode.
> 
Yes, it's definitely an interesting scenario, when a program can succeed in
enforcing but fail in permissive. Though it might help us convince more
people to run in enforcing ;-)

Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
