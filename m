Subject: Re: How can i remove net_raw capability from unconfined?
To: Gmail <pag.maurizio@gmail.com>, selinux@tycho.nsa.gov
References: <004b01d0f3a7$2425cf10$6c716d30$@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56006546.5000507@tycho.nsa.gov>
Date: Mon, 21 Sep 2015 16:15:02 -0400
MIME-Version: 1.0
In-Reply-To: <004b01d0f3a7$2425cf10$6c716d30$@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/20/2015 09:20 AM, Gmail wrote:
> Hi,
> 
>  
> 
> I need to understand how can i remove net_raw capability from
> unconfined_t domain, someone can help me?
> 
> I  need the source policy? Or can i remove another way? The systems are
> RHEL 6 and RHEL 7.

Yes, you would need to download the policy sources, modify the
unconfined policy module, rebuild it, and install your modified version.

It may be easier to instead define a new domain of your own that is
allowed everything but net_raw.
