Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n54LGa0X028468
	for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2009 17:16:36 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n54LGRnh016312
	for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2009 21:16:28 GMT
Message-ID: <4A283988.2090905@redhat.com>
Date: Thu, 04 Jun 2009 17:15:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Caleb Case <ccase@tresys.com>
CC: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: SELinux context patch
References: <4A11A5EC.9000904@redhat.com> <C639A340.A73BA%csellers@tresys.com> <150846cc0906041213n79e5e51ex3c72ab2cacb0ce64@mail.gmail.com>
In-Reply-To: <150846cc0906041213n79e5e51ex3c72ab2cacb0ce64@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/04/2009 03:13 PM, Caleb Case wrote:
> On Wed, May 20, 2009 at 12:08 PM, Chad Sellers<csellers@tresys.com>  wrote:
>> On 5/18/09 2:16 PM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
>>
>>> This patch adds context files for virtual_domain and virtual_image,
>>> these are both being used to locat the default context to be executed by
>>> svirt.
>>>
>>> I also included the subs patch which I submitted before.  This patch
>>> allows us to substitute prefixes to matchpathcon.
>>>
>>> So we can say /export/home == /home
>>>
>>> and
>>>
>>> /web == /var/www
>>
>> I'm surprised that the subs patch didn't get much discussion before. Any
>> thoughts on this? Any worries that it might not meld well with the work
>> currently being done to integrate FCGlob?
>>
>> Thanks,
>> Chad
>>
>
> I don't think it will adversely affect FCGlob integration.
>
> It is going to make it harder to understand what a file will get labeled though.
>
> Might be useful for genhomedircon to generate a .subs file and for
> refpolicy to provide labeling on a selinux user basis for home
> directories:
>
> /root
> /home/unconfined_u
> /home/sysadm_u
> ...
>
> with a .subs:
>
> /home/bob /home/unconfined_u
> /home/sally /home/sysadm_u
> ...
>
> It doesn't support directories with spaces in them.
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
I would like genhomedircon to just go away totally.   Or make it 
voluntary, not run in every policy update.   getpw() is not guaranteed 
to return all users in a Directory and setting up labeling for 100,000 
users is just kooky.

The beauty of this patch is it allows admin to take back control of 
labeling of homedir.  If they want to put home dirs in a random location 
and have symlinks from the HOMEDIR labeled in /etc/passwd
This will work.  I have had bug reports where people setup different 
HOMEDIR links depending on where the machine is at home or in the office 
or if they have a remove NFS and a local files.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
