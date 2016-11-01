Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA1FwNP0010233
 for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2016 11:58:23 -0400
Received: by mail-oi0-f51.google.com with SMTP id i127so301248470oia.2
 for <selinux@tycho.nsa.gov>; Tue, 01 Nov 2016 08:58:21 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Doyle <wpdster@gmail.com>
Date: Tue, 1 Nov 2016 11:57:48 -0400
Message-ID: <CAF_dkJA-3FNQ1m-8AQxrnWXsbiP+P86OUxeXHeRchh3pYZz70g@mail.gmail.com>
Subject: Is it possible to prevent a binary executable file from being read
 via SELinux?
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Background:
I have an embedded processor running a custom application on top of
Linux.  I control the kernel, the rootfs, and the application.  I
would like to deploy this application such that, if somebody were to
gain access to my device, even root access, (s)he would not be able to
read or copy the application from the device.

I don't know how or if the kernel would even support such a situation
-- if the executable is not readable, it should not be mappable, and
therefore the kernel would have a hard time swapping in pages from it.
So, I recognize that this may be an impossible request.

But it feels like the sort of thing somebody else should have wondered
about, and it feels like the sort of thing that SELinux might be able
to handle.

Any thoughts or recommendations?

I asked on IRC, and one person (grist) suggested that perhaps I should
encrypt the file.  I could do that, but then I find myself in the
situation of figuring out how to protect the encryption key on the
device.

I could implement a TEE (Trusted Execution Environment) on the device
or attach a TPM (Trusted Platform Module) to protect the key, but
those approaches add their own complexities.

Any thoughts or pointers would be gratefully accepted.

--wpd
