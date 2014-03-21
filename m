Message-ID: <532C4176.4060709@tycho.nsa.gov>
Date: Fri, 21 Mar 2014 09:41:10 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: kim.lawson-jenkins@nrl.navy.mil, selinux@tycho.nsa.gov
Subject: Re: How to restore a policy module
References: <01e101cf4509$9942ae60$cbc80b20$@nrl.navy.mil>
In-Reply-To: <01e101cf4509$9942ae60$cbc80b20$@nrl.navy.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/21/2014 09:29 AM, Kim Lawson-Jenkins wrote:
> In an attempt to lockdown a system I removed the remotelogin policy module
> using semodule -r.  I'm using the targeted policy on RHEL6.  How do I add
> this file back to my current configuration?
>

The pp file for the module will still be in /usr/share/selinux/targeted/.

To reinstall the module do:
semodule -i /usr/share/selinux/remotelogin.pp.bz2


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
