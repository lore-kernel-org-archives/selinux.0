MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: object class discovery userland
Date: Thu, 24 May 2007 19:55:52 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588BEFF30@exchange.columbia.tresys.com>
In-Reply-To: <465623DD.6090304@tycho.nsa.gov>
References: <1177077717.15762.32.camel@sgc> <4628F05B.7040309@tycho.nsa.gov>	 <4628F20E.2000208@tycho.nsa.gov>  <1177089541.24870.17.camel@sgc>	 <1177338792.24282.16.camel@moss-spartans.epoch.ncsc.mil>	 <6FE441CD9F0C0C479F2D88F959B01588A71927@exchange.columbia.tresys.com>	 <1177340283.24282.24.camel@moss-spartans.epoch.ncsc.mil> <1179929852.10995.51.camel@sgc.columbia.tresys.com> <46548D4E.50000@tycho.nsa.gov> <465623DD.6090304@tycho.nsa.gov>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "SELinux Mail List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Eamon Walsh wrote:
>> Christopher J. PeBenito wrote:
>>> The object manager will also have to be modified to get the new
>>> class and perm values on a policy reload.
>>> 
>> 
>> Sigh.  Maybe we _would_ be better off hiding the numeric values from
>> the caller. 
>> 
> 
> Maybe instead of just looking up class and permission values,
> object managers should be able to give libselinux a mapping from
> strings to numbers. 
> 
> For example, the X server could pass something like
> 
> {"xwindow", 1}
> 
> at startup time.  Then libselinux would internally convert 1
> to the real class value for xwindow, keeping track of any
> changes resulting from reloads.
> 
> The object managers are all going to have to do something
> like this anyway.  Doing it in the library could improve
> performance for AVC lookups, since the AVC entries could be
> keyed off the untranslated numbers.

This is interesting.. Then if the permission doesn't exist it would just
naturally be denied (or the library could respect the configuration if
there is such a thing) instead of the users being special cased. One
thing is that the avc remaps with permissions will be painful though.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
