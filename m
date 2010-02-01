Subject: Re: access decision API
From: Stephen Smalley <sds@tycho.nsa.gov>
To: michel m <michel.mcgregor@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <bb74313d1001300033g189165b9t7705614dcab0ced3@mail.gmail.com>
References: <bb74313d1001261320n8694abel857f6eba1066c560@mail.gmail.com>
	 <1264541641.19890.77.camel@moss-pluto.epoch.ncsc.mil>
	 <1264542993.19890.88.camel@moss-pluto.epoch.ncsc.mil>
	 <bb74313d1001270640s43b6c88dmafdb6aa9d3cf3015@mail.gmail.com>
	 <1264617201.17372.2.camel@moss-pluto.epoch.ncsc.mil>
	 <bb74313d1001300033g189165b9t7705614dcab0ced3@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 01 Feb 2010 09:28:06 -0500
Message-Id: <1265034486.12435.14.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2010-01-30 at 12:03 +0330, michel m wrote:
> as the last question, 
> what I need, is to ask the security server if a data residing in
> userspace owning a context, can be written to a file in OS.
> does it make sense if I do it in this way :
>     avc_has_perm(data_sid  ,file_sid,  SECLASS_FILE , null, null)
> 
> I am confused, because I guessed using such a syntax means if a
> process is able to write to file, but here we are going to check if
> data can be written to file.
> 
> if everything ok, how the action is specified, that is write?

I would recommend defining a new security class and permission for your
purpose to avoid confusion with existing ones and to avoid conflicts
with any future additions to the existing ones.  You can define new
classes and permissions by adding them to the security_classes and
access_vectors files under refpolicy/policy/flask in the reference
policy.  Then you can define your own SECCLASS_FOO and FOO__WRITE
definitions, and establish a mapping via selinux_set_mapping().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
