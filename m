Subject: Re: Bonobo
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <gyurdiev@redhat.com>
Cc: selinux@tycho.nsa.gov, David Malcolm <dmalcolm@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1117819380.22249.31.camel@dhcp83-8.boston.redhat.com>
References: <1117819380.22249.31.camel@dhcp83-8.boston.redhat.com>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 14:29:20 -0400
Message-Id: <1118341760.30110.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-03 at 13:23 -0400, Ivan Gyurdiev wrote:
> (sorry for 2 mails - posting on list this time) 
> 
> What can be done to restrict bonobo? 
> 
> My understanding is that bonobo allows applications to start other
> apps, based on searching for a particular capability. Mozilla uses
> bonobo, evolution uses bonobo, and pretty much any gnome app seems
> to use bonobo. What role should SElinux play in this process to 
> make the system more secure?
> 
> We've patched policy to implement per-domain labeling of orbit sockets,
> which restricts which apps can talk to which others over orbit. However,
> that doesn't seem sufficient. Currently bonobo runs as ROLE_t, and
> clients need to connect to it to launch other applications. That means:
> 
> (1) All bonobo clients are given the right to connect to
> ROLE_orbit_tmp_t sockets, which is the same as the orbit
> socket type for any ROLE_t applications.
> 
> I want to put bonobo in its own domain, but then it needs
> to be able to launch ROLE_t apps, and that becomes a problem.
> 
> (2) Bonobo can launch applications that ROLE_t can launch.
> The bonobo client could trick the bonobo server to launch the
> wrong applications. 
> 
> I'm interested in how userspace object managers work, and whether
> such a thing would be appropriate in this situation. It seems
> like it would be useful to enforce what can launch what else
> over bonobo, independent of the "search-by-capability" thing.

Take a look at the SELinux modification to dbusd.  Bonobo server should
be able to get the context of the client via getpeercon(3), and then use
the userspace AVC or the security API directly to get decisions about
proper labels to use for launched applications and whether or not such
applications should be launched by the client.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
