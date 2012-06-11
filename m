Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5BHLJ8k000405
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2012 13:21:19 -0400
Received: by dadg9 with SMTP id g9so5652395dad.12
        for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2012 10:21:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1339433473.8102.18.camel@moss-pluto.epoch.ncsc.mil>
References: <4FD61901.1010806@redhat.com>
	<1339433473.8102.18.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 11 Jun 2012 13:21:17 -0400
Message-ID: <CACLa4psYLPmN_279ORnnmB7acBu6AenFMFUmgb14+Mjj+BqiHg@mail.gmail.com>
Subject: Re: Boolean change of names.
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 11, 2012 at 12:51 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2012-06-11 at 12:12 -0400, Daniel J Walsh wrote:
>> We have started pushing a boolean change into Fedora 18.
>>
>> https://fedoraproject.org/wiki/Features/SELinuxBooleansRename
>>
>> The problem we are seeing is that boolean names used within an interface are
>> causing the install to fail on rebuild of policy.
>>
>> IE If I installed a custom policy with a boolean used in it, and the boolean
>> changed then the module will blow up the policy compile.
>>
>>
>> interface(`kerberos_manage_host_rcache',`
>>       gen_require(`
>>               type krb5_host_rcache_t;
>>       ')
>>
>> ...
>>
>>       tunable_policy(`allow_kerberos',`
>>               allow $1 self:process setfscreate;
>> ...
>>       ')
>>
>> ...
>> ')
>>
>> And change the allow_kerberos to kerberos_enabled.
>>
>> One idea would be to pull the translations into the semanage, or would I need
>> to do this at a lower level.  Or are we stuck with these bad names forever...
>
> Adding boolean aliases to the policy language, including kernel support,
> seems like the best route if you truly want to do this.

What does 'including kernel support' mean?  Expose both names in the
booleans/ directory?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
