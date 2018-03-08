MIME-Version: 1.0
In-Reply-To: <408e7eeb-2e44-4487-a976-775df79197c8@tycho.nsa.gov>
References: <20180305221611.19964-1-nicolas.iooss@m4x.org>
 <fde35f5b-92f0-5707-5af4-6e2ced3af8f6@tycho.nsa.gov>
 <408e7eeb-2e44-4487-a976-775df79197c8@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Thu, 8 Mar 2018 22:19:26 +0100
Message-ID: <CAJfZ7==qgVM0KwHdSJ2z7E4iifTx-CPjT3ikFfX4iorG6vOAXw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>, Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] libselinux,
 libsemanage: Replace PYSITEDIR with PYTHONLIBDIR
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Mar 8, 2018 at 8:34 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 03/06/2018 04:19 PM, Stephen Smalley wrote:
>> On 03/05/2018 05:16 PM, Nicolas Iooss wrote:
>>> libselinux and libsemanage Makefiles invoke site.getsitepackages() in
>>> order to get the path to the directory /usr/lib/pythonX.Y/site-packages
>>> that matches the Python interpreter chosen with $(PYTHON). This method
>>> is incompatible with Python virtual environments, as described in
>>> https://github.com/pypa/virtualenv/issues/355#issuecomment-10250452 .
>>> This issue has been opened for more than 5 years.
>>>
>>> On the contrary python/semanage/ and python/sepolgen/ Makefiles use
>>> distutils.sysconfig.get_python_lib() in order to get the site-packages
>>> path into a variable named PYTHONLIBDIR. This way of computing
>>> PYTHONLIBDIR is compatible with virtual environments and gives the same
>>> result as PYSITEDIR.
>>>
>>> As PYTHONLIBDIR works in more cases than PYSITEDIR, make libselinux and
>>> libsemanage Makefiles use it.
>>
>> On Fedora x86_64, this changes the install location from /usr/lib64 to /usr/lib.
>
> That said I agree we ought to be consistent, and it does seem that we are not currently.
> I'm just not sure what the best fix is in this case and the impact on distro packagers.

Good point. I have read
https://marc.info/?l=selinux&m=151670320132614&w=2 too quickly (and
missed "given that there's only pure python modules"). This message
suggests that doing using get_python_lib(plat_specific=1) would keep
/usr/lib64 on Fedora (unfortunately I only have access to Debian,
Ubuntu and Arch Linux systems right now so I am not able to test). And
to be consistent, I suggest naming the variable differently from
PYTHONLIBDIR. For example:

PYTHONPLATLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig
import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")

... or PYPLATLIBDIR if PYTHONPLATLIBDIR is too long. Or we also can
keep the name PYSITEDIR while changing its definition, in order to
minimize the impact. What would be acceptable?

Cheers,
Nicolas
