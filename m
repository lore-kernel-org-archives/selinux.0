Subject: Re: SE Android patch for internal fuse sdcard policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, seandroid@tycho.nsa.gov
In-Reply-To: <CAFftDdqD=SB5YVPMW1s9CKU3ot57PV=yzha0=qDUALiU9TiuaA@mail.gmail.com>
References: 
	 <CAFftDdqD=SB5YVPMW1s9CKU3ot57PV=yzha0=qDUALiU9TiuaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 31 May 2012 09:47:53 -0400
Message-ID: <1338472073.11009.33.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-05-30 at 17:43 -0400, William Roberts wrote:
> The attached patch handles the policy for /system/bin/sdcard. Most US
> and European bound Android handsets are moving to 'internal sdcard'
> which consists of a fuse file system faking the old FAT setup and
> writing to /data/media. This was tested on a Maguro device, but all
> other internal sdcard systems should be the same.
> 
> 
> Since sdcard was already in use, I called everything sdcardd*. 
> 
> 
> Also, I labeled /dev/fuse as a fuse_device, since other processes
> should not require access to the fuse device.  

Thanks, merged.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
