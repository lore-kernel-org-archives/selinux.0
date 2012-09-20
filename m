Message-ID: <1348152509.13835.23.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: seandroid 4.1.1
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexandra Test <testalexandrainstitute@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 20 Sep 2012 10:48:29 -0400
In-Reply-To: <CAKi3Puo9rREhxm_CTEYaRJtZJKf2XdK=EO0-jjDE+cQ12g-Zrg@mail.gmail.com>
References: 
	<CAKi3PupyLSM2UktjTaS8U-WKmiRSpRdSJApn2vRETfEx83qNfg@mail.gmail.com>
	 <1347988424.31966.56.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3Puqw0r=d31S+8N5_=JDN4_bK3TH2EODogOfAxTFxvDsdpg@mail.gmail.com>
	 <1348145727.13835.5.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3PuokYYQxCwf+SGga7UuguXBR14ZSneFMOfFQ-g0qX5btMA@mail.gmail.com>
	 <1348149606.13835.21.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3Puo9rREhxm_CTEYaRJtZJKf2XdK=EO0-jjDE+cQ12g-Zrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-09-20 at 16:10 +0200, Alexandra Test wrote:
> effectively I have a problem with dmesg
> is it possible I don't have the package installed? 
> this is the output....
> adb shell su 0 dmsg
> Usage: su [options] [LOGIN]
> 
> Options:
>   -c, --command COMMAND         pass COMMAND to the invoked shell
>   -h, --help                    display this help message and exit
>   -, -l, --login                make the shell a login shell
>   -s, --shell SHELL             use SHELL instead of the default in
> passwd
>   -v, --version                 display version number and exit
>   -V                            display version code and exit. this is
>                                 used almost exclusively by
> Superuser.apk
> root@alexandra:~/new/external/sepolicy# adb shell su 0 dmesg 

You aren't using the AOSP-provided su command there - that is
Superuser.apk from CM.  Anyway, you should be able to do this:
adb shell
su
dmesg


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
