Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4PBx0tY032767
	for <selinux@tycho.nsa.gov>; Wed, 25 May 2011 07:59:01 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p4PBwxvR011507
	for <selinux@tycho.nsa.gov>; Wed, 25 May 2011 11:59:00 GMT
Message-ID: <4DDCEF01.7050102@redhat.com>
Date: Wed, 25 May 2011 07:58:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sam Gandhi <samgandhi9@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Is it possible to assign different labels to symbolic links and
 actual files?
References: <BANLkTi=UEBFLWeWMov7GjOn_-Q3QuyTyxw@mail.gmail.com>	<4DDC1E11.2020200@redhat.com> <BANLkTi=eLtqov9i0pXpXJkwNK74cc4mUAw@mail.gmail.com>
In-Reply-To: <BANLkTi=eLtqov9i0pXpXJkwNK74cc4mUAw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/24/2011 05:46 PM, Sam Gandhi wrote:
> On Tue, May 24, 2011 at 2:07 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 05/24/2011 04:46 PM, Sam Gandhi wrote:
>>> Hello,
>>>
>>> I am working on a embedded platform and we have busybox on this device.
>>>
>>> What we would like to do do is assign diffrent labels to various
>>> busybox links. What we have seen when running things on JFFS2 when I
>>> label a symbolic link, the actual file gets the label, but the link
>>> itself doesn't (according to ls -lZ output).  We have seen similar
>>> behaviour with files on tmpfs as well.
>>>
>>> ls -lZ
>>> -rw-r--r--        1         0 Jan  1 00:12 system_u:object_r:myfile_t X
>>> lrwxrwxrwx    1         1 Jan  1 00:13 user_u:object_r:tmpfs_t          Y -> X
>>>
>>> Is there no way to assign different label to symlink and actual files?
>>> Is this file-system specific issue? Are there any file-system that
>>> support assigning seperate labels to symlink and actual file?
>>>
>>> -Sam
>>>
>>> --
> 
>>>
>>>
>> Yes you can label symbolic links differently then their targets, how are
>> you assiging the labels?
>>
> 
> I am using setfilecon program found in package
> On tmpfs file I did :
> 
> cd /tmp/
> touch X
> ln -s X Y
> setfilecon system_u:object_r:myfile_t Y
> 
> And I see ls -lZ output as I shown above which shows /tmp/X has the
> myfile_t label and not Y
> 
> I can't really use tools like semanage 'cause I can't install python
> on this system. I will try to "reverse" engineer what semanage does
> and how it handles symlink v/s regular files.
> 
> -Sam
Use chcon instead of setfilecon
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3c7wEACgkQrlYvE4MpobNYAACgvI/CIEJ1AuXBYFVM0wMAtFae
qpgAniOIEfmzeMrOgav+8oRIigT/AhNJ
=9kUk
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
