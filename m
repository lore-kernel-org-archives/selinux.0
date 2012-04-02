Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q32FFl3s016247
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2012 11:15:47 -0400
Message-ID: <4F79C2A0.10101@redhat.com>
Date: Mon, 02 Apr 2012 11:15:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: noloader@gmail.com
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Adding a booleans.subs file to selinux policy.
References: <4F75D80E.4010905@redhat.com> <CAH8yC8kr9v1v6yzFcntoG_zHD=U-TAXqBqmNbQFu-SN0AiaCAA@mail.gmail.com>
In-Reply-To: <CAH8yC8kr9v1v6yzFcntoG_zHD=U-TAXqBqmNbQFu-SN0AiaCAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/30/2012 08:07 PM, Jeffrey Walton wrote:
> On Fri, Mar 30, 2012 at 11:58 AM, Daniel J Walsh <dwalsh@redhat.com>
> wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> Basically I am sick of some of the bad names we chose for booleans when
>> we were first writing policy, so I want a mechanism to allow us to change
>> the names but still support the old names.
>> 
>> This patch will allow policy developers to ship a 
>> /etc/selinux/targeted/contexts/booleans.subs
>> 
>> Then libselinux will check if a boolean name exists, if not it will see
>> if there is a substitute name and attempt to use that.
>> 
>> I have attached the libselinux_bools-subs.patch and the first pass at
>> what a booleans.subs file will look like in Fedora 18.
> +static int bool_open(const char *name, int flag) { ... + +	len =
> strlen(name) + strlen(selinux_mnt) + sizeof(SELINUX_BOOL_DIR); Calling
> strlen() on NULL is not valid C, IIRC.
> 
> +	snprintf(fname, len, "%s%s%s", selinux_mnt, SELINUX_BOOL_DIR, name); 
> Silent truncation?
> 
> Should work under benign conditions. Will probably fail in a hostile 
> environment.
> 
> Jeff
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.

Ok adding


	if (!name) {
		errno = EINVAL;
		return fd;
	}

At the beginning of bool_open.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk95wqAACgkQrlYvE4MpobOW1gCfWqW9HitmVXgRBG5CVMJRi8U6
AqUAmwT5g4X4Q5TNWAjwdvTuXe/+7Fgn
=L56v
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
