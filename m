Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4IFRZ8N003277
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 11:27:36 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4IFRgVb016500
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 15:27:43 GMT
Message-ID: <4A117E5D.5000409@manicmethod.com>
Date: Mon, 18 May 2009 11:27:25 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch matchpathcon to eliminate file "/"
References: <C60D1DD3.A6857%csellers@tresys.com>
In-Reply-To: <C60D1DD3.A6857%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Sellers wrote:
> On 3/4/09 3:39 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
> 
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> So
>>
>> matchpathcon /etc/
>> Will work the same as
>> matchpathcon /etc
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.9 (GNU/Linux)
>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>>
>> iEYEARECAAYFAkmu5wMACgkQrlYvE4MpobNK4gCgiVeXXEZcCMsJKXM7jqh6r1u3
>> OScAoLcmXBIR63gpvA8RS3g07pcPC6IF
>> =e+Re
>> -----END PGP SIGNATURE-----
>> --- nsalibselinux/utils/matchpathcon.c 2008-10-28 10:06:51.000000000 -0400
>> +++ libselinux-2.0.78/utils/matchpathcon.c 2009-03-04 15:23:52.000000000 -0500
>> @@ -101,6 +101,11 @@
>> for (i = optind; i < argc; i++) {
>> int mode = 0;
>> struct stat buf;
>> +  int len = strlen(argv[i]);
>> +  if (len > 1  && argv[i][len - 1 ] == '/') {
>> +   argv[i][len - 1 ] = '\0';
>> +  }
>> +
>> if (lstat(argv[i], &buf) == 0)
>> mode = buf.st_mode;
>>  
> 
> Looks fine to me.
> 
> Acked-by: Chad Sellers <csellers@tresys.com>
> 

Merged in libselinux-2.0.81

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
