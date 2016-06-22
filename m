Subject: Re: New rules on restrict kernel module loading
To: Ravi Kumar <nxp.ravi@gmail.com>, seandroid-list@tycho.nsa.gov
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
Cc: Selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <08990cf3-6a88-53e4-6418-9c00de017d7a@tycho.nsa.gov>
Date: Wed, 22 Jun 2016 14:58:08 -0400
MIME-Version: 1.0
In-Reply-To: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/22/2016 01:35 PM, Ravi Kumar wrote:
> Hi team , 
> 
> I see some new changes  both in kernel and sepolicy project on
> restricting the load of kernel module  . 
> 
> https://android-review.googlesource.com/#/c/213758/ -- kernel change  on
> check for moudle_load request  by Jeff 
> https://android-review.googlesource.com/#/c/214021/-- sepolicy change
> adding the neverallow  on module_load request  by Jeff .
> 
> As most of the  SoC /OEM has there own KO  which are loaded on run-time
> detection an mostly running in system_app/system_server/platfrom_app
>  are there any special guideline here . 
> 
> As an good example  wlan.ko  .

The neverallow only prohibits loading from a target file other than
system_file or rootfs.  So as long as your module lives in /system or /,
you should just be able to allow permission as needed.  That said, not
sure why that would trigger from an app context; I would expect it to be
more likely from one of the domains already allowed module_request
permission (e.g. system_server, wpa, ...).
