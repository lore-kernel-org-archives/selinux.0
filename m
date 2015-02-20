Message-ID: <54E77264.9070905@tycho.nsa.gov>
Date: Fri, 20 Feb 2015 12:44:04 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Tracy Reed <treed@ultraviolet.org>
Subject: Re: MCS error
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
 <20150219204841.GA1649@linksys-wireless-usb.network2>
 <20150220003425.GF12937@tracyreed.org> <20150220020213.GG12937@tracyreed.org>
In-Reply-To: <20150220020213.GG12937@tracyreed.org>
Content-Type: text/plain; charset=windows-1252
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/19/2015 09:02 PM, Tracy Reed wrote:
> On Thu, Feb 19, 2015 at 04:34:25PM PST, Tracy Reed spake thusly:
>> # semanage login -l
> 
> Ok, part of my confusion here is that I've been confusing semanage login with
> semanage user. It's been a while since I've dealt with SELinux. I understand
> that semanage login -l shows what Linux users map to what selinux users:
> 
>> Login Name                SELinux User              MLS/MCS Range            
>>
>> __default__               unconfined_u              SystemLow-SystemHigh     
>> p16001                    p16001_u                  p16001                   
>> p16002                    appuser_u                 s0:c1.c499-s0:c2         
>> p16003                    appuser_u                 s0:c1.c499-s0:c3         
>> p16004                    unconfined_u              s0-s0:c0.c1023,c4        
>> p16005                    unconfined_u              s0-s0:c0.c1023,c4,c5     
>> p16006                    unconfined_u              s0-s0:c0.c1023,c6        
>> p16007                    unconfined_u              s0-s0:c0.c1023,c7        
>> p16008                    unconfined_u              s0-s0:c0.c1023,c8        
>> p16009                    unconfined_u              s0-s0:c0.c1023,c9        
>> root                      unconfined_u              SystemLow-SystemHigh     
>> system_u                  system_u                  SystemLow-SystemHigh  
> 
> So we are mapping p16002 to appuser_u but appuser_u doesn't exist at the
> moment. But what's with the MLS/MCS range column?  Is this saying p16002 has
> categories s0:c1.c499-s0:c2 is it saying appuser_u (selinux user) has
> categories s0:c1.c499-s0:c2? Given that the selinux user is the same but the
> categories listed are different for Linux login users p16002 and p16003 I would
> think it is saying those categories go with those Linux login users.

The user mapping (i.e. semanage user) is part of the kernel policy; for
each SELinux user, it specifies the maximum range and authorized roles
for the user.  The login mapping (i.e. semanage login) is a purely
userspace policy; it specifies how to map a given Linux login to a
SELinux user and to a more specific range.  The more specific range for
a Linux login should always be a subset of the range authorized for the
underlying SELinux user; the kernel won't let you create a process with
a given SELinux user with a range that exceeds the maximum authorized in
its policy.  So your login mapping is wrong.

> And that is different yet with respect to the output of the chcat command:
> 
> # chcat -L -l p16001 p16002
> p16001: s0:c0.c1023
> p16002: s0:c0.c1023
> 
> This says p16001 and p16002 have access to all categories.

I wouldn't rely on chcat for anything; I'm not sure it is even being
maintained as it only made sense for the original user-centric
discretionary MCS model.  Just use semanage to manage the login and user
mappings, and chcon -l to set levels on files (or, better, add entries
to file contexts via semanage fcontext and use restorecon to set the
labels to match; otherwise a relabel may override them).
