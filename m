Subject: Re: [SEMANAGE,SEPOL,UTILS] Improve port/fcontext type string API
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43DBDBE7.2030405@cornell.edu>
References: <43DBDBE7.2030405@cornell.edu>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 15:18:30 -0500
Message-Id: <1138652310.7076.181.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-01-28 at 14:02 -0700, Ivan Gyurdiev wrote:
> Improve:
> 
> [semanage/sepol]_port_get_proto_str
> [semanage/sepol]_fcontext_get_type_str
> 
> to take the integer code, and not the record as an argument.
> This makes more sense, as the removal of several sepol FIXMEs 
> demonstrate (we can get the type code from places other than the 
> record... from its key, or from sepol structures). This is an API 
> change, dependencies fixed in the patch.

Merged as of libsepol 1.11.10, libsemanage 1.5.19, and policycoreutils
1.29.16.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
