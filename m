Message-ID: <4E3B0AB1.2050707@redhat.com>
Date: Thu, 04 Aug 2011 17:10:09 -0400
From: Eric Paris <eparis@redhat.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 029/155] policycoreutils: fixfiles clean up /var/run and
References: <4E39B5E6.8000100@redhat.com>  <1312469767.20973.53.camel@moss-pluto>  <CACLa4ptckXGt6XEqDMnmeZhV3AzVwnL=ktSTtVTFGg+A=Ajcug@mail.gmail.com>  <CACLa4puk2gO=aV=oNj-Kmj=eSmYmquX0skKoCxso6o9tWcf_Ng@mail.gmail.com> <1312486409.20973.66.camel@moss-pluto> <4E3B007B.1020502@redhat.com> <4E3B085D.1050400@redhat.com> <4E3B09CA.30604@redhat.com>
In-Reply-To: <4E3B09CA.30604@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/04/2011 05:06 PM, Daniel J Walsh wrote:
> On 08/04/2011 05:00 PM, Eric Paris wrote:

>> I also question the use of /sys/fs/selinux/ but I'm not sure we have
>> a good way to find that in a script.....  Do we have one?
>>
> 
> grep selinuxfs /proc/self/mountinfo | awk '{ print $5 }'

$ grep selinuxfs /proc/self/mountinfo | awk '{ print $5 }'
/selinux
/chroot/selinux

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
