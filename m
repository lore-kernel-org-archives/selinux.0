Message-ID: <447A20C4.704@gentoo.org>
Date: Sun, 28 May 2006 18:14:28 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Mohammad Mahmoudi <mahmoudi1379@yahoo.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: Revocation Support
References: <20060528115017.96102.qmail@web50413.mail.yahoo.com> <447A1C33.2040200@gentoo.org>
In-Reply-To: <447A1C33.2040200@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Mohammad Mahmoudi wrote:
>> Does SELinux support revocation of permissions?
>>   
> The FLASK architecture, which SELinux is based on, does indeed support 
> revocation by allowing object managers to register callbacks with the 
> security server. However, on SELinux, this is not currently in use. So 
> direct revocation where the object managers actively remove access to 
> objects after a policy change doesn't happen.
>
> However, on some object classes permission is revalidated on every 
> object use (like files and file descriptors). So, even though a 
> process has a file descriptor to a file it previously had access top 
> open, if the permissions change to that file type the next read or 
> write operation will fail which essentially revokes access to it. This 
> should be the case on a file types, fds, sockets, ipc (except shared 
> memory).
>
> Hope this helps..
> <http://us.rd.yahoo.com/mymod/showtimes/X-Men:%20The%20Last%20Stand/SIG=13eg95e87/*https://www.movietickets.com/purchase.asp?afid=myyah&house_id=8612&movie_id=44681&perfd=05282006&perft=23:30> 
>
>
Neat, I dont' know how that link got in my email but it was obviously an 
accident :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
