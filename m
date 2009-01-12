Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0CHX2fl005725
	for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2009 12:33:02 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n0CHUGgb014915
	for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2009 17:30:16 GMT
Message-ID: <496B7EC7.7040408@manicmethod.com>
Date: Mon, 12 Jan 2009 12:32:55 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Now that F11 has started, I am putting in the compression support.
References: <49144E3F.8080904@redhat.com> <4967A44B.1080903@manicmethod.com> <496B63B3.6030905@redhat.com>
In-Reply-To: <496B63B3.6030905@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Joshua Brindle wrote:
>> Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> libsemanage patch to add compression.
>>>
>>> Uses bzip compression, all pp files in active/previous stored in
>>> compressed state.  Added new interfaces to be user by policycoreutils to
>>> specify file rather then memory map.
>>>
>>> Also uses link instead of copy whenever possible to save disk space.
>>> Seeing about a 10 fold savings on policy footprint.
>> resend
>>

Ok, I'm getting some errors with the new patch. I did semodule -l on my 
F10 system:

[method@riddler selinux]$ sudo semodule -l
libsemanage.semanage_direct_list: Out of memory!
semodule:  Failed on list!


gdb'ing it I see:
1320                    if ((size = bunzip(fp, &data)) != 0) {
(gdb)
1321                            fclose(fp);
(gdb)
1322                            fp = fmemopen(data, size, "rb");
(gdb)
1323                            if (!fp) {

(gdb) print fp
$1 = (FILE *) 0x0
(gdb) print errno
$2 = 12
(gdb) call perror()
Cannot allocate memory
$4 = 0
(gdb) print size
$5 = 4294967295
(gdb) print module_filenames[i]
$6 = 0x8b34b18 "/etc/selinux/targeted/modules/active/modules/ada.pp"

[method@riddler selinux]$ sudo file 
/etc/selinux/targeted/modules/active/modules/ada.pp
/etc/selinux/targeted/modules/active/modules/ada.pp: data

So this is not a compressed module

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
