To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux <selinux@tycho.nsa.gov>
References: <CAJfZ7=niujB=XSC5D=y3fPrcL7rBBuLCsN_G=sy0N0bfDRYNJQ@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <59efc4ed-6d05-ec2c-2089-e2b08ddfc495@tycho.nsa.gov>
Date: Wed, 5 Sep 2018 16:19:32 -0400
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=niujB=XSC5D=y3fPrcL7rBBuLCsN_G=sy0N0bfDRYNJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: "semanage user" and -s option
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/05/2018 03:36 PM, Nicolas Iooss wrote:
> Hello,
> 
> While reviewing the last patch sent by Vit Mojzis, I stumbled upon
> something that does not feel right in "semanage user". Both "semanage
> user --help" and "man 8 semanage-user" state:
> 
> usage: semanage user [-h] [-n] [-N] [-S STORE] [ --add ( -L LEVEL -R
> ROLES -r RANGE -s SEUSER selinux_name) | ...
> 
> I am wondering what are the meaning of "-s SEUSER" and "selinux_name"
> there. If I try to use "-s" option, semanage complains:
> 
> semanage: error: unrecognized arguments: -s
> 
> Therefore it seems that the usage would rather be "... --add ( -L
> LEVEL -R ROLES -r RANGE SEUSER)". Looking at the code, it seems that
> parser_add_seuser() is not used in setupUserParser() [1], and
> everything works fine when using "semanage user" without -s option. Am
> I missing something obvious, or should I write a patch which fixes the
> documentation?

Sounds like a cut-and-paste error from the semanage login help and man page.

The examples in the man page don't ever use -s to semanage user, nor 
does python/semanage/test-semanage.py or python/sepolicy/templates/*.py.

> 
> Cheers,
> Nicolas
> 
> [1] https://github.com/SELinuxProject/selinux/blob/libsemanage-2.8/python/semanage/semanage#L403
