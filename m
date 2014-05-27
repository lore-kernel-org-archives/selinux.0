Message-ID: <5384D1EE.7030106@tycho.nsa.gov>
Date: Tue, 27 May 2014 13:57:02 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: =?UTF-8?B?dG9hzIluIGN1zIA=?= <xuantoanbkfet@gmail.com>,
 selinux@tycho.nsa.gov
Subject: Re: change selinux user's roles
References: <CANh19KBDGC4PPBitWUeFov-=1Mc51wBmfGYf0c3Zuy5-rtJAjA@mail.gmail.com>
In-Reply-To: <CANh19KBDGC4PPBitWUeFov-=1Mc51wBmfGYf0c3Zuy5-rtJAjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/27/2014 01:45 PM, toản cù wrote:
> Hi all!
> 
> I want to change a selinux user's role 
> Examble: 
>    Linux account: ToanCu and relation with SELinux user staff_u (staff_u
> can access a number of roles staff_r, system_r, unconfiled_r, sysadm_r) 
> when I checked context of user by command *# id,* i have context of
> selinux user : 
> uid=502(ToanCu) gid=503(ToanCu) groups=503(ToanCu)
> *context=staff_u:staff_r:staff_t:s0-s0:c0.c1023*
> 
> I want to change the context above to : *context:
> staff_u:sysadm_r:staff_t:s0-s0:c0.c1023*
> 
> Look forward your help!
> 
> Thanks!

newrole -r sysadm_r

or

sudo -r sysadm_r <command>
