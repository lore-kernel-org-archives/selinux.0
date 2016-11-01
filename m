MIME-Version: 1.0
In-Reply-To: <706f5fa7-f73a-641b-2a50-4e58ede933a4@tycho.nsa.gov>
References: <CAF_dkJA-3FNQ1m-8AQxrnWXsbiP+P86OUxeXHeRchh3pYZz70g@mail.gmail.com>
 <706f5fa7-f73a-641b-2a50-4e58ede933a4@tycho.nsa.gov>
From: Patrick Doyle <wpdster@gmail.com>
Date: Tue, 1 Nov 2016 18:41:13 -0400
Message-ID: <CAF_dkJAW6hyo8r+m=0AuJRkLV4kA_zFM=5tOQd2iWuFHJjb8Pw@mail.gmail.com>
Subject: Re: Is it possible to prevent a binary executable file from being
 read via SELinux?
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thank you for your reply.

On Tue, Nov 1, 2016 at 3:45 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> If you can't get rid of root services entirely, then SELinux can extend
> this protection to even root processes.  You'd probably want a custom
> policy from scratch for that kind of scenario; see the Android policy
> for an example.
A custom policy is most likely what I want... my question is... can I
set up such a policy that disallows reading (and, by extension,
copying) of an executable binary, and yet still be able to execute it?
 A related question would be: can I bake that policy immutably into
the kernel so that it cannot be disabled?  While I can't prevent
physical access to the device, I can encrypt the kernel & rootfs
(embedded as a cramfs) as a single binary blob, so I think (hope) that
is as secure as my encryption key.  I would also do all of the normal
hardening stuff of disabling loadable modules, shutting down network
services, etc...

--wpd
