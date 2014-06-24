Message-ID: <53A9D819.30806@tycho.nsa.gov>
Date: Tue, 24 Jun 2014 15:57:13 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov,
 Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH 0/2] Bug fixes for libsemanage/src/pywrap-test.py
References: <1402765106-7397-1-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1402765106-7397-1-git-send-email-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/14/2014 12:58 PM, Nicolas Iooss wrote:
> Hello,
> 
> While working on porting to Python scripts in sepolgen and
> policycoreutils to Python 3, I found libsemanage/src/pywrap-test.py.
> As this script is written in Python 2, I tried to make it compatible
> with Python 3 too.  However there are at least two problems:
> 
> * The current script bugs when asked to perform all tests in verbose
> mode. Here are two patches to fix the script.  Can you review and
> apply them?

Thanks, applied on #next.

> * The file indentation mixes tabs and spaces.  Python 2 understands
> such a thing but Python 3 only supports indenting with tabs or spaces
> but not both.  How should the scripts be indented?

I would say spaces as per PEP-8 but I don't really care either way.

> 
> Nicolas Iooss (2):
>   libsemanage: fix src/pywrap-test.py -v -F
>   libsemanage: use semanage_bool_get_value to print a boolean
> 
>  libsemanage/src/pywrap-test.py | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
