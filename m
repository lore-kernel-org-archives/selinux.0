Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t09MMoke010954
 for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2015 17:22:53 -0500
Received: by mail-la0-f49.google.com with SMTP id hs14so16776648lab.8
 for <selinux@tycho.nsa.gov>; Fri, 09 Jan 2015 14:22:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAB9W1A3Y_+gZv=ZWGTGvuk_z8P_Ys7SVNAUz8wRCS1EDW_dcJg@mail.gmail.com>
References: <1420837553.31986.2.camel@gmail.com>
 <CAB9W1A3Y_+gZv=ZWGTGvuk_z8P_Ys7SVNAUz8wRCS1EDW_dcJg@mail.gmail.com>
Date: Fri, 9 Jan 2015 16:22:51 -0600
Message-ID: <CAHZ_AjsxSJ3adY-UeMfik9xzOczk1411hk_ckSRPNbBOFSkwbA@mail.gmail.com>
Subject: Re: RFC: https://bugzilla.redhat.com/show_bug.cgi?id=1174405
From: eric gisse <jowr.pi@gmail.com>
To: Stephen Smalley <stephen.smalley@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I disagree.

I've had to have technical discussions justifying my belief that
certain common things should be available to all domains such as
/dev/urandom and more recently /proc/sys/vm/overcommit_memory.

Discussions around those reasonable defaults basically rotate around
the philsophical notion of least privilege.

So seeing there's an entire swath of ports that programs can bind to
by default is crazytalk and blows that notion out of the water.

Further, it is bad policy.

Consider sshd, or any other daemon that does nothing but bind to a
port and listen for connections.

It does not need the ability to bind to to anything other than its'
daemon port, not even epheremal ports. Yet it can, regardless of
policy considerations. Which is the underlying point here.

If someone gains access to a server through a compromised service,
they can bind a backdoor to that epheremal range or at least exfil
data.

This is bad, bad, bad and rather surprising because until it was
pointed out by this thread I would not have considered it possible due
to the...vehemence... in which least privilege has been upheld.




On Fri, Jan 9, 2015 at 3:52 PM, Stephen Smalley
<stephen.smalley@gmail.com> wrote:
> Ports in the local port range can be auto-assigned by the kernel to
> unbound sockets on first use.  So it makes no sense to control them,
> and there isn't even an LSM hook in the place where such auto-port
> selection occurs.  Controlling binding to ports is only useful when
> the port number is a "name" (i.e. a well-defined value that is
> expected to correspond to a specific service), to prevent spoofing of
> security-relevant services like sshd.
>
> On Fri, Jan 9, 2015 at 4:05 PM, Dominick Grift <dac.override@gmail.com> wrote:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1174405
>>
>> This is a inconsistency in SELinux
>>
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
