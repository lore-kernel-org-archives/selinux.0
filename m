In-Reply-To: <1173185188.15967.25.camel@moss-spartans.epoch.ncsc.mil>
References: <D043357D-5AD2-4C8E-8282-63E4045EF0F4@sf-net.com> <1173185188.15967.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4A5A2930-96CD-485E-AD4C-A0D251E582F0@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: AVC denials debug
Date: Wed, 7 Mar 2007 11:43:03 +0100
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> There are presently only indirect ways of flushing the AVC:
> - reload policy (just run load_policy even w/o a new policy),
> - switch from permissive to enforcing (setenforce 1),
> - set a boolean value (setsebool <someboolean>=<somevalue>, even the
> same as it is presently)
>
> Each of these three operations will flush the AVC in order to ensure
> that it remains consistent with the current policy state.  I  
> suppose we
> could add another selinuxfs node under /selinux/avc to allow manual
> flushes, but since you can indirectly do it just by reloading your
> existing policy or setting a boolean to the value it already has, it
> isn't really necessary.


Yeah, I think load_policy is enough. It's fast and convenient.


> You can build policy with the 'enableaudit' target (make  
> enableaudit) to
> build a base module that has all dontaudit rules removed from it and
> then install that base module; in Fedora, that base module is built  
> and
> installed as /usr/share/selinux/$SELINUXTYPE/enableaudit.pp for use by
> users.  However, that only addresses the base module presently, not
> non-base modules.

Ok, I will have a look at the dontaudit-base-only-module. Maybe this  
will be enough.

Thanks for all the detailed explanations!

Best regards,
Stefan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
