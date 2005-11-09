Subject: Re: [ LIBSEMANAGE ] Cleanup patch (resync-ed)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux-dev@tresys.com, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43718447.30709@cornell.edu>
References: <43718447.30709@cornell.edu>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 08:54:24 -0500
Message-Id: <1131544464.20591.478.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-09 at 00:08 -0500, Ivan Gyurdiev wrote:
> Same cleanup patch as before, resync-ed against latest changes.
> 
> Changes:
> - fold semanage_module_conn into semanage_direct_handle
> - move sepol handle initialization and destruction into 
> semanage_handle_create/destroy, to allow use of the handle when 
> disconnected, which is consistent with current record interfaces (they 
> do not require a connection).

Seems sane, but I'd like an ack from Tresys.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
