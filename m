Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0BFn7d2012672
 for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2015 10:49:08 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so10322549wid.5
 for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2015 07:49:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150110191517.GA30004@bigboy.network2>
References: <1420837553.31986.2.camel@gmail.com>
 <CAB9W1A3Y_+gZv=ZWGTGvuk_z8P_Ys7SVNAUz8wRCS1EDW_dcJg@mail.gmail.com>
 <CAHZ_AjsxSJ3adY-UeMfik9xzOczk1411hk_ckSRPNbBOFSkwbA@mail.gmail.com>
 <14ad1cb43d8.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <1420883781.24061.22.camel@gmail.com>
 <CAB9W1A2Ro0mTqOwJOBL=9S9SaE0C_sXw3MUKpGP4L9VQObokYw@mail.gmail.com>
 <20150110171950.GA23358@bigboy.network2>
 <20150110174300.GA28262@bigboy.network2>
 <CAB9W1A1rLu_5XnMXqn0kbR0yhD-D39RmBTF12=1Kz320Hv5iEA@mail.gmail.com>
 <20150110191517.GA30004@bigboy.network2>
Date: Sun, 11 Jan 2015 10:49:03 -0500
Message-ID: <CAHC9VhQXUqQJErLXuadhapft2_=o81mmBmbZ0nDKRHBAHE0H+g@mail.gmail.com>
Subject: Re: RFC: https://bugzilla.redhat.com/show_bug.cgi?id=1174405
From: Paul Moore <paul@paul-moore.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Jan 10, 2015 at 2:15 PM, Dominick Grift <dac.override@gmail.com> wrote:
> On Sat, Jan 10, 2015 at 01:54:01PM -0500, Stephen Smalley wrote:
>> Well, I noted it in the technical reports I wrote originally for
>> SELinux.  I guess it didn't get carried into documentation written by
>> others, although it has been discussed on this list and the Fedora
>> SELinux list various times.  Also, even if we were to implement such a
>> check, we'd have to dontaudit it in most cases because the kernel
>> would automatically be scanning the range for an available and allowed
>> port, and various userspace libraries do exactly the same thing when
>> trying to bind to an available port.  Which would render it a
>> mysterious denial on random send/connect and bind calls.
>
> You hinted that implementing a check for this could affect performance, and so i am no longer in favor of that solution.
>
> however i would like some of the tools to be aware of this issue.
>
> for example if i do
>
> sesearch -A -s sshd_t -t port_type -c tcp_socket -p name_bind
>
> That it returns somehow that this access to ports in the local port range will be allowed. So that auditors see that it is allowed even though there is no rule to allow it.
> At least then they know there is something going on and can look for documentation about it.
>
> The problem is how does one implement that in an informative way without relying on customizable identifiers.

Perhaps a mention in the relevant man pages?

-- 
paul moore
www.paul-moore.com
