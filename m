Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB4E8r5I016562
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 09:08:53 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB4E8pNt011069
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 14:08:51 GMT
Message-ID: <47555F24.1040402@redhat.com>
Date: Tue, 04 Dec 2007 09:07:32 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: Martin Orr <martin@martinorr.name>,
        =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?=
 <vaclav.ovsik@i.cz>,
        selinux@tycho.nsa.gov
Subject: Re: refpolicy HEAD, Debian, patch for udev.te
References: <20071126144547.GA334@bobek.pm.i.cz>	 <1196189369.30997.6.camel@gorn> <474F1BD4.2010908@martinorr.name>	 <20071130134933.GA11780@bobek.pm.i.cz> <1196433514.4298.42.camel@gorn>	 <20071130153024.GA13299@bobek.pm.i.cz> <1196438149.4298.43.camel@gorn>	 <47504744.9040202@martinorr.name> <1196551302.4808.6.camel@defiant.pebenito.net>
In-Reply-To: <1196551302.4808.6.camel@defiant.pebenito.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Chris PeBenito wrote:
> On Fri, 2007-11-30 at 17:24 +0000, Martin Orr wrote:
>> On 30/11/07 15:55, Christopher J. PeBenito wrote:
>>> On Fri, 2007-11-30 at 16:30 +0100, Václav Ovsík wrote:
>>>> On Fri, Nov 30, 2007 at 09:38:33AM -0500, Christopher J. PeBenito wrote:
>>>>>> Corresponding code is in udev_node.c, function node_symlink().
>>>>>>     if (strcmp(target, buf) == 0) {
>>>>>> 	    info("preserve already existing symlink '%s' to '%s'", slink,
>>>>>> target);
>>>>>> 	    selinux_setfilecon(slink, NULL, S_IFLNK);
>>>>>> 	    goto exit;
>>>>>>     }
>>>>> I'll add the rule.  Perhaps someone should send up a patch to remove the
>>>>> setfilecon, and update the info message.
>>>> Mean you to compare the context of symlink and no setfilecon if it is
>>>> ok?
>>> Yes.  Unless there's a good reason to keep it as-is that I don't know
>>> about.
>> Well I'll send a patch to udev.  Should it just be the below, or should udev
>> be relabelling symlinks if it finds that they exist but are wrongly
>> labelled?  How do I test for equality of security contexts?
>>
>> --- a/udev_node.c
>> +++ b/udev_node.c
>> @@ -146,7 +146,6 @@ static int node_symlink(const char *node, const char *slink)
>>  				buf[len] = '\0';
>>  				if (strcmp(target, buf) == 0) {
>>  					info("preserve already existing symlink '%s' to '%s'", slink, target);
>> -					selinux_setfilecon(slink, NULL, S_IFLNK);
>>  					goto exit;
>>  				}
>>  			}
> 
> Yes, thats what I was thinkin.  Since the function is node_symlink(),
> I'm guessing there is a similar function for char and block node, etc?
> Those should be checked to make sure they don't do unneeded relabeling
> too.
> 
My patch for Fedora adds the ability for udev to relabelto relabelfrom
device_t symlinks.

Even if you fix udev, these rules should be added. since you could label
the symlink as something other than device_t.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD4DBQFHVV8krlYvE4MpobMRAtxBAJY2hqXrkH7QkzBui/M4c0pm7AOrAKCmGb0L
ILY0KxrCkluMfknbtr43UA==
=1VyK
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
