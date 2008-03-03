MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PATCH: fix uninitialized use of handle in struct policy_file
Date: Mon, 3 Mar 2008 17:34:17 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880195CE84@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880195CE83@exchange.columbia.tresys.com>
References: <200803032220.m23MKUZp003057@cadmus.columbia.tresys.com> <47CC7B7F.9060200@tresys.com> <6FE441CD9F0C0C479F2D88F959B015880195CE83@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Todd Miller" <tmiller@tresys.com>
Cc: <selinux@tycho.nsa.gov>, <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd Miller wrote:
> Joshua Brindle wrote:
>> Hrm. Why aren't we using an initializer for this struct so that this
>> sort of thing doesn't happen?
> 
> That's probably a nicer approach, I was going for a minimal change.
> I suppose at its simplest the initializer could just memset()
> the struct.  Alternately, it could take the values to set as
> parameters. 
> 

I prefer it to memset or set the values to null explicitly, the caller
can then set the members it wants to.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
