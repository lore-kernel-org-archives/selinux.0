Message-ID: <537F6395.6000002@tresys.com>
Date: Fri, 23 May 2014 11:04:53 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>, James Carter
 <jwcart2@tycho.nsa.gov>
Subject: Re: secilc: in statement ordering limitations
References: <1400689802.5957.5.camel@x220.localdomain>
 <537F4A07.70403@tycho.nsa.gov> <1400855557.10370.4.camel@x220.localdomain>
In-Reply-To: <1400855557.10370.4.camel@x220.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/23/2014 10:32 AM, Dominick Grift wrote:
> On Fri, 2014-05-23 at 09:15 -0400, James Carter wrote:
> 
>> Could you give me a little bit more information on what you are doing?
> 
> Strange.. It is kind of hard for me to put it any other way.
> 
> I have a short 5 minute video that demo's the issue:
> 
> https://www.youtube.com/watch?v=hU_yVZJpAyM
> 
> If you are not able to view the demo then i guess i will have to find
> another way to explain it
> 

I think this is an example of the core problem:

  (in foo.bar
    (type x))

  (in foo
    (block bar))

  (block foo)

So, an in-statement is inserting into a block that is created by another
in-statement, so there's an order dependence.

- Steve
