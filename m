Message-ID: <43579792.4070105@tresys.com>
Date: Thu, 20 Oct 2005 09:11:46 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux-dev@tresys.com, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>, Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [RFC] sectioned package format
References: <1129748381.15338.20.camel@twoface.columbia.tresys.com> <1129811174.2375.333.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129811174.2375.333.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2005-10-19 at 14:59 -0400, Joshua Brindle wrote:
> 
>>This is our proposal for sectioned package formats, it addresses the 
>>issues brought up on the fedora-selinux list and the selinux list. It
>>allows for forward/backward compatibility by being able to skip unknown 
>>sections. It also allows for 'fat' packages, which may contain modules 
>>for multiple distributions, targeted/strict/MLS, and so on within the 
>>same package. We believe this format is extensible and fairly future
>>proof, please give us feedback so that we can start implementing this.
> 
> 
> Do we think that these "fat" module packages will actually be used in
> practice, or that people will just build separate module packages for
> the variants?   BTW, possible point of confusion due to overloaded
> terminology:  "module package" is not related to a traditional Linux
> "package" (i.e. something managed by rpm or dpkg), so a traditional
> "package" could contain multiple "module packages".
> 

Fair enough. This idea may be a little over engineered, we'll think 
about the problem some more and send something simpler for comments 
today or tomorrow.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
