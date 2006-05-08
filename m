Subject: setrans client support in libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <4458D192.6060105@redhat.com>
References: <4458D192.6060105@redhat.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 08:58:39 -0400
Message-Id: <1147093119.23640.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-03 at 11:51 -0400, Daniel J Walsh wrote:
> I am looking to remove libsetrans altogether and put the setrans_client 
> into libselinux and then create a mcstrans package which would just me 
> the mcs translation daemon.
> 
> This patch includes the last patch on libselinux.
> 
> These packages will need to be added/updated simultaneously.

Merged.  This moves the client-side support for a translation daemon
directly into libselinux, eliminating the use of a separate libsetrans.
However, we need to think about how to optimize to avoid the
socket/connect/close overhead on every libselinux function, particularly
when no daemon is present at all.  I experimented briefly with creating
and connecting a socket during library initialization and re-using it
for subsequent calls, with code to recreate it if the connection was
reset, but this didn't seem to work well with sshd; likely it is closing
descriptors during setup of the unprivileged child process for privilege
separation, and the descriptor is being reused for some other purpose.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
