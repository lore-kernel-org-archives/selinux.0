Subject: Re: inaddr_any_node_t?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Larry Ross <selinux.larry@gmail.com>
Cc: Selinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <AANLkTinACSXGyYqwI-cBkQki1PoaKUHK1sDxkKwRHGCE@mail.gmail.com>
References: <AANLkTinACSXGyYqwI-cBkQki1PoaKUHK1sDxkKwRHGCE@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Jun 2010 13:30:19 -0400
Message-ID: <1275499819.9475.157.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-06-02 at 08:32 -0700, Larry Ross wrote:
> Where can I find the definition and purpose of "inaddr_any_node_t"?
> 
> It looks like it matches any port for networking rules but I can't
> find where it is defined or any documentation on it.  The only place I
> see it (other than my policy, where it came as the output from
> audit2allow) is in tmp/all_interfaces.conf
> 
> Where is it defined?
> 
> How can I find out what its purpose is and how it works?
> 
> I am using a customized RHEL5.4 strict policy.

At one time node_inaddr_any_t was defined to be the type for address
0.0.0.0 (INADDR_ANY as defined by netinet/in.h and used in bind(2) calls
to bind to all interfaces), and showed up in node_bind permission checks
when a process attempted to bind to all interfaces.

I think that modern policy ships without any node context definitions by
default, deferring that entirely to the admin to configure via semanage
node or the like, so the type may just be a residual type alias for
node_t at this point for compatibility.  You should be able to tell by
looking at the policy sources or by examining the binary policy via apol
or the like.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
