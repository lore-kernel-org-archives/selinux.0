Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4OLkdFT026231
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 17:46:39 -0400
Received: from mail-iy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p4OLkXX7018501
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 21:46:34 GMT
Received: by iyb26 with SMTP id 26so6931213iyb.12
        for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 14:46:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4DDC1E11.2020200@redhat.com>
References: <BANLkTi=UEBFLWeWMov7GjOn_-Q3QuyTyxw@mail.gmail.com>
	<4DDC1E11.2020200@redhat.com>
Date: Tue, 24 May 2011 14:46:33 -0700
Message-ID: <BANLkTi=eLtqov9i0pXpXJkwNK74cc4mUAw@mail.gmail.com>
Subject: Re: Is it possible to assign different labels to symbolic links and
 actual files?
From: Sam Gandhi <samgandhi9@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 24, 2011 at 2:07 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 05/24/2011 04:46 PM, Sam Gandhi wrote:
>> Hello,
>>
>> I am working on a embedded platform and we have busybox on this device.
>>
>> What we would like to do do is assign diffrent labels to various
>> busybox links. What we have seen when running things on JFFS2 when I
>> label a symbolic link, the actual file gets the label, but the link
>> itself doesn't (according to ls -lZ output).  We have seen similar
>> behaviour with files on tmpfs as well.
>>
>> ls -lZ
>> -rw-r--r--        1         0 Jan  1 00:12 system_u:object_r:myfile_t X
>> lrwxrwxrwx    1         1 Jan  1 00:13 user_u:object_r:tmpfs_t          Y -> X
>>
>> Is there no way to assign different label to symlink and actual files?
>> Is this file-system specific issue? Are there any file-system that
>> support assigning seperate labels to symlink and actual file?
>>
>> -Sam
>>
>> --

>>
>>
> Yes you can label symbolic links differently then their targets, how are
> you assiging the labels?
>

I am using setfilecon program found in package
On tmpfs file I did :

cd /tmp/
touch X
ln -s X Y
setfilecon system_u:object_r:myfile_t Y

And I see ls -lZ output as I shown above which shows /tmp/X has the
myfile_t label and not Y

I can't really use tools like semanage 'cause I can't install python
on this system. I will try to "reverse" engineer what semanage does
and how it handles symlink v/s regular files.

-Sam


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
