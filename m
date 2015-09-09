Subject: Re: secilc: any idea why this commit causes secilc to segfault?
To: James Carter <jwcart2@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
References: <20150909093802.GA22288@x250> <55F080F6.6060707@tycho.nsa.gov>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <55F08333.6080206@tresys.com>
Date: Wed, 9 Sep 2015 15:06:27 -0400
MIME-Version: 1.0
In-Reply-To: <55F080F6.6060707@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/09/2015 02:56 PM, James Carter wrote:
> On 09/09/2015 05:38 AM, Dominick Grift wrote:
> disclaimer: although i have thoroughly tested this commit for typo's, i
> cannot completely rule out that this seqfault is caused by a typo.
> 
> 
>> Not a typo, it is a bug in secilc. Secilc doesn't seem to like having a
>> classpermissionset statement in a tunableif block.
> 

Looks like we just aren't initializing things properly in cil_copy.c.
Patch coming shortly.

- Steve
