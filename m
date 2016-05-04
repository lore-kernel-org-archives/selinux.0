Subject: Re: SELinux build errors
To: David Merritt <david.d.merritt@gmail.com>
References: <CAMyQ4FwP25QU3EvAfw0oLQuH1x05S6G8a=F7G9vnsk2duJyCvg@mail.gmail.com>
 <8c58805a-6fc9-11b3-825a-c45529662d64@tycho.nsa.gov>
 <CAMyQ4FxDwjXXvu3k7rsuvN2XiWuh5Jgq-uO9oC_K6o+uQz+Lxg@mail.gmail.com>
 <cea43a9e-085a-bf3d-6ad0-43cc7a2f4332@tycho.nsa.gov>
 <1a0c60c1-63d1-7b7d-404c-b36d2b1d308d@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <87b76047-fd2f-8f9c-c9f1-e934bdcf19fe@tycho.nsa.gov>
Date: Wed, 4 May 2016 13:16:05 -0400
MIME-Version: 1.0
In-Reply-To: <1a0c60c1-63d1-7b7d-404c-b36d2b1d308d@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/04/2016 01:13 PM, Stephen Smalley wrote:
> On 05/04/2016 01:01 PM, Stephen Smalley wrote:
>> On 05/04/2016 12:55 PM, David Merritt wrote:
>>> i've stood up a fedora 23 VM to build and test on...but am hitting
>>> multiple errors in compilation as well as missing packages.
>>>
>>> has this been successfully built on 23?
>>
>> Yes, builds fine for me on f23.  You installed the dependencies listed
>> in the README?
> 
> It also builds fine on centos 7 for me as long as I pass
> CFLAGS+=-Wno-sign-compare to make.

Although I did have to install xmlto for building the secilc man page.
Added to the list of packages in the README.
