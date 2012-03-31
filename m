Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2V07GTK012814
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2012 20:07:26 -0400
Received: by vcge1 with SMTP id e1so913555vcg.12
        for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2012 17:07:05 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
In-Reply-To: <4F75D80E.4010905@redhat.com>
References: <4F75D80E.4010905@redhat.com>
Date: Fri, 30 Mar 2012 20:07:05 -0400
Message-ID: <CAH8yC8kr9v1v6yzFcntoG_zHD=U-TAXqBqmNbQFu-SN0AiaCAA@mail.gmail.com>
Subject: Re: Adding a booleans.subs file to selinux policy.
From: Jeffrey Walton <noloader@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Mar 30, 2012 at 11:58 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Basically I am sick of some of the bad names we chose for booleans when we
> were first writing policy, so I want a mechanism to allow us to change the
> names but still support the old names.
>
> This patch will allow policy developers to ship a
> /etc/selinux/targeted/contexts/booleans.subs
>
> Then libselinux will check if a boolean name exists, if not it will see if
> there is a substitute name and attempt to use that.
>
> I have attached the libselinux_bools-subs.patch and the first pass at what a
> booleans.subs file will look like in Fedora 18.
+static int bool_open(const char *name, int flag) {
    ...
+
+	len = strlen(name) + strlen(selinux_mnt) + sizeof(SELINUX_BOOL_DIR);
Calling strlen() on NULL is not valid C, IIRC.

+	snprintf(fname, len, "%s%s%s", selinux_mnt, SELINUX_BOOL_DIR, name);
Silent truncation?

Should work under benign conditions. Will probably fail in a hostile
environment.

Jeff

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
