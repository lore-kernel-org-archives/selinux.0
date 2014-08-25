From: "Stepan G. Fedorov" <stfedorov@gmail.com>
Message-ID: <53FB4192.8090203@gmail.com>
Date: Mon, 25 Aug 2014 18:00:50 +0400
MIME-Version: 1.0
To: Selinux@tycho.nsa.gov
Subject: Re: semanage interface has no effect
References: <53FB19C7.1040500@gmail.com> <53FB35D2.3030307@tycho.nsa.gov>
In-Reply-To: <53FB35D2.3030307@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

25.08.2014 17:10, Stephen Smalley пишет:
> Legacy network checks are gone; use peer labeling or secmark instead, 
> http://paulmoore.livejournal.com/tag/documentation 

Thank you for quick reply!

In case of "just installed" system, where no iptables SECMARK rules 
present, and no labeled packets arrive on network interface - what will 
be selinux contexts of all incoming packets?

-- 
Stepan G. Fedorov <StFedorov@gmail.com>
Tel: +7-965-750-91-91
