Subject: Re: semodule -i not working
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Shaz <shazalive@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <7b740b700808260251l55f56127n8668e777dacbe26f@mail.gmail.com>
References: <7b740b700808260251l55f56127n8668e777dacbe26f@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 26 Aug 2008 07:10:47 -0400
Message-Id: <1219749047.2721.197.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-08-26 at 14:51 +0500, Shaz wrote:
> I was trying to load the following module:
> ---------------------------------
>      module spamd 1.0;
> 
>      require {
>      role object_r;
>      role system_r;
> 
>      class tcp_socket name_connect;
> 
>      type ldap_port_t;
>      type spamd_t;
>      };
> 
>      allow spamd_t ldap_port_t:tcp_socket name_connect;
> --------------------------------
> 
> and I got the following error:
> 
>      [root@develap lpm]# semodule -i spamd.pp
>      libsepol.module_package_read_offsets: wrong magic number for
> module package:  expected 4185718671, got 1969516397
>      libsemanage.parse_module_headers: Could not parse module data.
>      semodule:  Failed on spamd.pp!
> 
> How do I understand the problem and what can be the possible solution?

How did you build spamd.pp?  And what versions of libsepol, libsemanage,
and policycoreutils are you using?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
