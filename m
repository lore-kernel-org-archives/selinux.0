Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7V6bP4n007728
 for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2016 02:37:25 -0400
Received: from process-dkim-sign-daemon.mr25p46im-ztdg02111301.me.com by
 mr25p46im-ztdg02111301.me.com
 (Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26 2016))
 id <0OCR00J00GSCAU00@mr25p46im-ztdg02111301.me.com> for selinux@tycho.nsa.gov;
 Wed, 31 Aug 2016 06:37:21 +0000 (GMT)
From: ileyd <ileyd@icloud.com>
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (1.0)
Subject: Re: SELinux MLS Policies
Message-id: <9D586F02-4DA2-450A-9E31-541A97D554BE@icloud.com>
Date: Wed, 31 Aug 2016 16:37:18 +1000
References: <"01e601d202e0$7aaf62d0$700e2870$@a.bolton"@m0noc.net>
 <dcfa502a-a210-2815-33a7-825d905e4be6@tycho.nsa.gov>
 <612965bc-952f-9f95-ca14-7c8a8c6e7b6e@m0noc.net>
In-reply-to: <612965bc-952f-9f95-ca14-7c8a8c6e7b6e@m0noc.net>
To: Paul Bolton <paul.a.bolton@m0noc.net>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> On 31 Aug 2016, at 6:52 AM, Paul Bolton <paul.a.bolton@m0noc.net> wrote:
> 
> 
> 
>> On 30/08/16 20:19, Stephen Smalley wrote:
>>> On 08/30/2016 01:03 PM, Paul Bolton wrote:
>>> 
>>> Why is the target context for evaluation kernel_t and not devlog_t?
>>> Surely it should be devlog_t and therefore pass the constraint rule as a
>>> trusted object?
>> 
>> sendto is a permission check between the two socket labels, not to be
>> confused with the file label.  When you send on a local/Unix socket, you
>> need write permission to the socket file (if using the file namespace;
>> if using the abstract namespace, there is no equivalent check) and you
>> need sendto to the peer socket (which typically will be labeled the same
>> as the receiving process).  So the receiving process is running in
>> kernel_t, or was at the time it created the socket.
>> 
>> There are two separate kernel objects when dealing with Unix sockets -
>> the file and the socket itself.
> 
> Thanks for the explanation.
> 
> So, I guess in my example AVC, after a bit of digging to get the CentOS
> src patches, where we have the following added to sshd.te, it is the
> mls_process_write_all_levels() that clears that AVC.
> 
> policy-rhel-7.2-base.patch:
> -- snip --
> +mls_trusted_object(sshd_t)
> +mls_process_write_all_levels(sshd_t)
> +mls_dbus_send_all_levels(sshd_t)
> -- snip --
> 
> -- 
> Paul
> ----
> http://blog.m0noc.com/ | https://keybase.io/m0noc
> 4329 E4C5 71F3 58B2 2246  D04D 25DA 39C2 3876 FE3D
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

Have you managed to correct the incorrect labelling of /etc?  When I've tried to use the MLS policy on RHEL/CentOS 7-7.2, that has stopped logins from working when running in enforcing mode.
