<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LoopsIT.Default1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Loops IT</title>
    <link rel="icon" type="image/png" href="Home/img/favicon.png" sizes="16x16" />

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="robots" content="default, index, follow" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Computer Software Companies in Bangladesh. List of Software Companies in Bangladesh. Offshore Development Center (ODC). Computer Hardware & Software Companies in Bangladesh Computer Software Company List Internet Service Providers Web design Companies" />
    <meta name="author" content="Loops IT" />
    
    <link href="Home/css/home-page.css?v=1.0.1" rel="stylesheet" />
    <style>
        #map-canvas { width: 100%; height: 500px; }

        @media (max-width: 767px) {
            #main-flexslider ul.slides li p { font-size: 30px !important; }
            #header-wrapper { min-height: 300px; }
            form { margin: 0 0 0; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- navbar -->
        <div class="navbar-wrapper">
            <div class="navbar navbar-inverse navbar-fixed-top">
                <div class="navbar-inner">
                    <div class="container">
                        <!-- Responsive navbar -->
                        <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                        </a>
                        <h1 class="brand"><a href="Default.aspx">Loops IT</a></h1>
                        <!-- navigation -->
                        <nav class="pull-right nav-collapse collapse">
                            <ul id="menu-main" class="nav">
                                <li><a title="team" href="#about">About</a></li>
                                <li><a title="services" href="#services">Services</a></li>
                                <%--   <li><a title="works" href="#works">Works</a></li>
                        <li><a title="blog" href="#blog">Blog</a></li>--%>
                                <li><a title="contact" href="#contact">Contact</a></li>

                                <asp:LoginView ID="CustomerLoginView" runat="server">
                                    <AnonymousTemplate>
                                        <li><a href="Login.aspx">Login</a></li>
                                    </AnonymousTemplate>
                                    <LoggedInTemplate>
                                        <li><a href="../../Profile_Redirect.aspx">Profile</a></li>
                                        <li>
                                            <asp:LoginStatus ID="LoginStatus1" runat="server" LogoutPageUrl="~/Default.aspx" LogoutAction="Redirect" CssClass="login_Out" OnLoggingOut="LoginStatus1_LoggingOut" />
                                        </li>
                                    </LoggedInTemplate>
                                </asp:LoginView>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>

        <!-- Header area -->
        <div id="header-wrapper" class="header-slider">
            <header class="clearfix">
                <div class="logo">
                    <img src="Home/img/logo-image.png" alt="" />
                </div>
                <div class="container">
                    <div class="row">
                        <div class="span12">
                            <div id="main-flexslider" class="flexslider">
                                <ul class="slides">
                                    <li>
                                        <p class="home-slide-content">
                                            <strong>Education</strong> Management Software
                                        </p>
                                    </li>
                                    <li>
                                        <p class="home-slide-content">
                                            <strong>Tailoring</strong> Management Software
                                        </p>
                                    </li>
                                    <li>
                                        <p class="home-slide-content">
                                            <strong>Unique Attendance</strong> Device Solution
                                        </p>
                                    </li>
                                </ul>
                            </div>
                            <!-- end slider -->
                        </div>
                    </div>
                </div>
            </header>
        </div>

        <!-- spacer section -->
        <section class="spacer green">
            <div class="container">
                <div class="row">
                    <div class="span6 alignright flyLeft">
                        <blockquote class="large">
                            There's huge space beetween creativity and imagination <cite>Mark Simmons, Nett Media</cite>
                        </blockquote>
                    </div>
                    <div class="span6 aligncenter flyRight">
                        <i class="icon-coffee icon-10x"></i>
                    </div>
                </div>
            </div>
        </section>

        <!-- section: team -->
        <section id="about" class="section">
            <div class="container">
                <h4>Who We Are</h4>
                <div class="row">
                    <div class="span4 offset1">
                        <div>
                            <h2>We live with <strong>creativity</strong></h2>
                            <p>
                                We aim to provide great customer service. For product inquiries, technical support, and legal questions, here are all the ways you can contact Loops IT                    
                            </p>
                        </div>
                    </div>
                    <div class="span6">
                        <div class="aligncenter">
                            <img src="Home/img/icons/creativity.png" alt="" />
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="span2 flyIn">
                        <div class="people">
                            <img class="team-thumb img-circle" src="Home/img/team/Mahbub.jpg" alt="Mahbubur Rahman" />
                            <h3>Mahbubur Rahman</h3>
                            <p>
                                Chairman
                            </p>
                        </div>
                    </div>
                    <div class="span2 flyIn">
                        <div class="people">
                            <img class="team-thumb img-circle" src="Home/img/team/a.rahman.jpg" alt="Abdur Rahman" />
                            <h3>Abdur Rahman</h3>
                            <p>
                                Managing Director
                            </p>
                        </div>
                    </div>
                    <div class="span2 flyIn">
                        <div class="people">
                            <img class="team-thumb img-circle" src="Home/img/team/Satter.jpg" alt="Abdus Satter" />
                            <h3>Abdus Satter</h3>
                            <p>
                                Director of Services
                            </p>
                        </div>
                    </div>
                    <div class="span2 flyIn">
                        <div class="people">
                            <img class="team-thumb img-circle" src="Home/img/team/Ishak.JPG" alt="Hamim Ishak" />
                            <h3>Hamim Ishak</h3>
                            <p>
                                Director of Marketing
                            </p>
                        </div>
                    </div>
                    <div class="span2 flyIn">
                        <div class="people">
                            <img class="team-thumb img-circle" src="Home/img/team/moni.jpg" alt="Shahed Al Mahmud" />
                            <h3>Shahed Al Mahmud</h3>
                            <p>
                                Director of Programs
                            </p>
                        </div>
                    </div>
                    <div class="span2 flyIn">
                        <div class="people">
                            <img class="team-thumb img-circle" src="Home/img/team/Muhib.JPG" alt="Muhibollah" />
                            <h3>Muhibollah</h3>
                            <p>
                                Director of IT
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.container -->
        </section>

        <!-- section: services -->
        <section id="services" class="section orange">
            <div class="container">
                <h4>Services</h4>
                <!-- Four columns -->
                <div class="row">
                    <div class="span3 animated-fast flyIn">
                        <div class="service-box">
                            <img src="Home/img/icons/laptop.png" alt="" />
                            <h2>Web design</h2>
                            <p>
                                Our team is very much experienced & creative in the field of web design
                            </p>
                        </div>
                    </div>
                    <div class="span3 animated flyIn">
                        <div class="service-box">
                            <img src="Home/img/icons/lab.png" alt="" />
                            <h2>Web development</h2>
                            <p>
                                Our team develop any kind of software as clients requirements
                            </p>
                        </div>
                    </div>
                    <div class="span3 animated-fast flyIn">
                        <div class="service-box">
                            <img src="Home/img/icons/camera.png" alt="" />
                            <h2>Software Service</h2>
                            <p>
                                We provide Software service like education,tailoring and erp management software
                            </p>
                        </div>
                    </div>
                    <div class="span3 animated-slow flyIn">
                        <div class="service-box">
                            <img src="Home/img/icons/basket.png" alt="" />
                            <h2>Ecommerce</h2>
                            <p>
                                Our team develop Ecommerce as clients requirements
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- end section: services -->

        <!-- section: works -->
        <%--<section id="works" class="section">
         <div class="container clearfix">
            <h4>Our Works</h4>
            <!-- portfolio filter -->
            <div class="row">
               <div id="filters" class="span12">
                  <ul class="clearfix">
                     <li><a href="#" data-filter="*" class="active">
                        <h5>All</h5>
                     </a></li>
                     <li><a href="#" data-filter=".web">
                        <h5>Web</h5>
                     </a></li>
                     <li><a href="#" data-filter=".print">
                        <h5>Print</h5>
                     </a></li>
                     <li><a href="#" data-filter=".design">
                        <h5>Design</h5>
                     </a></li>
                     <li><a href="#" data-filter=".photography">
                        <h5>Photography</h5>
                     </a></li>
                  </ul>
               </div>
               <!-- END PORTFOLIO FILTERING -->
            </div>
            <div class="row">
               <div class="span12">
                  <div id="portfolio-wrap">
                     <!-- portfolio item -->
                     <div class="portfolio-item grid print photography">
                        <div class="portfolio">
                           <a href="Home/img/works/big.jpg" data-pretty="prettyPhoto[gallery1]" class="portfolio-image">
                              <img src="Home/img/works/1.png" alt="" />
                              <div class="portfolio-overlay">
                                 <div class="thumb-info">
                                    <h5>Portfolio name</h5>
                                    <i class="icon-plus icon-2x"></i>
                                 </div>
                              </div>
                           </a>
                        </div>
                     </div>
                     <!-- end portfolio item -->
                     <!-- portfolio item -->
                     <div class="portfolio-item grid print design web">
                        <div class="portfolio">
                           <a href="Home/img/works/big.jpg" data-pretty="prettyPhoto[gallery1]" class="portfolio-image">
                              <img src="Home/img/works/2.png" alt="" />
                              <div class="portfolio-overlay">
                                 <div class="thumb-info">
                                    <h5>Portfolio name</h5>
                                    <i class="icon-plus icon-2x"></i>
                                 </div>
                              </div>
                           </a>
                        </div>
                     </div>
                     <!-- end portfolio item -->
                     <!-- portfolio item -->
                     <div class="portfolio-item grid print design">
                        <div class="portfolio">
                           <a href="Home/img/works/big.jpg" data-pretty="prettyPhoto[gallery1]" class="portfolio-image">
                              <img src="Home/img/works/3.png" alt="" />
                              <div class="portfolio-overlay">
                                 <div class="thumb-info">
                                    <h5>Portfolio name</h5>
                                    <i class="icon-plus icon-2x"></i>
                                 </div>
                              </div>
                           </a>
                        </div>
                     </div>
                     <!-- end portfolio item -->
                     <!-- portfolio item -->
                     <div class="portfolio-item grid photography web">
                        <div class="portfolio">
                           <a href="Home/img/works/big.jpg" data-pretty="prettyPhoto[gallery1]" class="portfolio-image">
                              <img src="Home/img/works/4.png" alt="" />
                              <div class="portfolio-overlay">
                                 <div class="thumb-info">
                                    <h5>Portfolio name</h5>
                                    <i class="icon-plus icon-2x"></i>
                                 </div>
                              </div>
                           </a>
                        </div>
                     </div>
                     <!-- end portfolio item -->
                     <!-- portfolio item -->
                     <div class="portfolio-item grid photography web">
                        <div class="portfolio">
                           <a href="Home/img/works/big.jpg" data-pretty="prettyPhoto[gallery1]" class="portfolio-image">
                              <img src="Home/img/works/5.png" alt="" />
                              <div class="portfolio-overlay">
                                 <div class="thumb-info">
                                    <h5>Portfolio name</h5>
                                    <i class="icon-plus icon-2x"></i>
                                 </div>
                              </div>
                           </a>
                        </div>
                     </div>
                     <!-- end portfolio item -->
                     <!-- portfolio item -->
                     <div class="portfolio-item grid photography web">
                        <div class="portfolio">
                           <a href="Home/img/works/big.jpg" data-pretty="prettyPhoto[gallery1]" class="portfolio-image">
                              <img src="Home/img/works/6.png" alt="" />
                              <div class="portfolio-overlay">
                                 <div class="thumb-info">
                                    <h5>Portfolio name</h5>
                                    <i class="icon-plus icon-2x"></i>
                                 </div>
                              </div>
                           </a>
                        </div>
                     </div>
                     <!-- end portfolio item -->
                     <!-- portfolio item -->
                     <div class="portfolio-item grid photography web">
                        <div class="portfolio">
                           <a href="Home/img/works/big.jpg" data-pretty="prettyPhoto[gallery1]" class="portfolio-image">
                              <img src="Home/img/works/7.png" alt="" />
                              <div class="portfolio-overlay">
                                 <div class="thumb-info">
                                    <h5>Portfolio name</h5>
                                    <i class="icon-plus icon-2x"></i>
                                 </div>
                              </div>
                           </a>
                        </div>
                     </div>
                     <!-- end portfolio item -->
                     <!-- portfolio item -->
                     <div class="portfolio-item grid photography">
                        <div class="portfolio">
                           <a href="Home/img/works/big.jpg" data-pretty="prettyPhoto[gallery1]" class="portfolio-image">
                              <img src="Home/img/works/8.png" alt="" />
                              <div class="portfolio-overlay">
                                 <div class="thumb-info">
                                    <h5>Portfolio name</h5>
                                    <i class="icon-plus icon-2x"></i>
                                 </div>
                              </div>
                           </a>
                        </div>
                     </div>
                     <!-- end portfolio item -->
                     <!-- portfolio item -->
                     <div class="portfolio-item grid photography web">
                        <div class="portfolio">
                           <a href="Home/img/works/big.jpg" data-pretty="prettyPhoto[gallery1]" class="portfolio-image">
                              <img src="Home/img/works/9.png" alt="" />
                              <div class="portfolio-overlay">
                                 <div class="thumb-info">
                                    <h5>Portfolio name</h5>
                                    <i class="icon-plus icon-2x"></i>
                                 </div>
                              </div>
                           </a>
                        </div>
                     </div>
                     <!-- end portfolio item -->
                     <!-- portfolio item -->
                     <div class="portfolio-item grid design web">
                        <div class="portfolio">
                           <a href="Home/img/works/big.jpg" data-pretty="prettyPhoto[gallery1]" class="portfolio-image">
                              <img src="Home/img/works/10.png" alt="" />
                              <div class="portfolio-overlay">
                                 <div class="thumb-info">
                                    <h5>Portfolio name</h5>
                                    <i class="icon-plus icon-2x"></i>
                                 </div>
                              </div>
                           </a>
                        </div>
                     </div>
                     <!-- end portfolio item -->
                  </div>
               </div>
            </div>
         </div>
      </section>--%>

        <!-- section: blog -->
        <%--<section id="blog" class="section">
         <div class="container">
            <h4>Our Blog</h4>
            <!-- Three columns -->
            <div class="row">
               <div class="span3">
                  <div class="home-post">
                     <div class="post-image">
                        <img class="max-img" src="Home/img/blog/img1.jpg" alt="" />
                     </div>
                     <div class="post-meta">
                        <i class="icon-file icon-2x"></i>
                        <span class="date">June 19, 2013</span>
                        <span class="tags"><a href="#">Design</a>, <a href="#">Blog</a></span>
                     </div>
                     <div class="entry-content">
                        <h5><strong><a href="#">New design trends</a></strong></h5>
                        <p>
                           Lorem Ipsum is simply dummy text of the printing and typesetting industry. &hellip;
                        </p>
                        <a href="#" class="more">Read more</a>
                     </div>
                  </div>
               </div>
               <div class="span3">
                  <div class="home-post">
                     <div class="post-image">
                        <img class="max-img" src="Home/img/blog/img2.jpg" alt="" />
                     </div>
                     <div class="post-meta">
                        <i class="icon-file icon-2x"></i>
                        <span class="date">June 19, 2013</span>
                        <span class="tags"><a href="#">Design</a>, <a href="#">News</a></span>
                     </div>
                     <div class="entry-content">
                        <h5><strong><a href="#">Retro is great</a></strong></h5>
                        <p>
                           Lorem Ipsum is simply dummy text of the printing and typesetting industry. &hellip;
                        </p>
                        <a href="#" class="more">Read more</a>
                     </div>
                  </div>
               </div>
               <div class="span3">
                  <div class="home-post">
                     <div class="post-image">
                        <img class="max-img" src="Home/img/blog/img3.jpg" alt="" />
                     </div>
                     <div class="post-meta">
                        <i class="icon-file icon-2x"></i>
                        <span class="date">June 22, 2013</span>
                        <span class="tags"><a href="#">Design</a>, <a href="#">Tips</a></span>
                     </div>
                     <div class="entry-content">
                        <h5><strong><a href="#">Isometric mockup</a></strong></h5>
                        <p>
                           Lorem Ipsum is simply dummy text of the printing and typesetting industry. &hellip;
                        </p>
                        <a href="#" class="more">Read more</a>
                     </div>
                  </div>
               </div>
               <div class="span3">
                  <div class="home-post">
                     <div class="post-image">
                        <img class="max-img" src="Home/img/blog/img4.jpg" alt="" />
                     </div>
                     <div class="post-meta">
                        <i class="icon-file icon-2x"></i>
                        <span class="date">June 27, 2013</span>
                        <span class="tags"><a href="#">News</a>, <a href="#">Tutorial</a></span>
                     </div>
                     <div class="entry-content">
                        <h5><strong><a href="#">Free icon set</a></strong></h5>
                        <p>
                           Lorem Ipsum is simply dummy text of the printing and typesetting industry. &hellip;
                        </p>
                        <a href="#" class="more">Read more</a>
                     </div>
                  </div>
               </div>
            </div>
            <div class="blankdivider30"></div>
            <div class="aligncenter">
               <a href="#" class="btn btn-large btn-theme">More blog post</a>
            </div>
         </div>
      </section>--%>

        <!-- section: contact -->
        <section id="contact" class="section green">
            <div class="container">
                <h4>Contact US</h4>
                <p class="text-center" id="map-input">
                    House # 328, Shohid Biplob Shoroni, East Nakhal Para, Tejgaon,<br />
                    cross-streets of shopno super shop, Dhaka 1215<br />
                </p>
                <p class="text-center">
                    Mail: <a href="mailto:info.loopsit.com" style="color: #fff; text-decoration: underline;">info.loopsit.com</a>
                </p>
                <div class="row">
                    <div class="span12">
                        <div class="cform" id="contact-form">
                            <div id="sendmessage">Your message has been sent. Thank you!</div>
                            <div id="errormessage"></div>
                            <div class="contactForm">
                                <div class="row">
                                    <div class="span6">
                                        <div class="field your-name form-group">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="Name_TextBox" ForeColor="Red" ValidationGroup="1"></asp:RequiredFieldValidator>
                                            <asp:TextBox ID="Name_TextBox" runat="server" CssClass="form-control" placeholder="Your Name"></asp:TextBox>

                                        </div>
                                        <div class="field your-email form-group">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="Mail_TextBox" ForeColor="Red" ValidationGroup="1"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid E-Mail" ControlToValidate="Mail_TextBox" ForeColor="White" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="1"></asp:RegularExpressionValidator>
                                            <asp:TextBox ID="Mail_TextBox" runat="server" CssClass="form-control" placeholder="Your Email"></asp:TextBox>

                                        </div>
                                        <div class="field subject form-group">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="Subject_TextBox" ForeColor="Red" ValidationGroup="1"></asp:RequiredFieldValidator>
                                            <asp:TextBox ID="Subject_TextBox" runat="server" CssClass="form-control" placeholder="Subject"></asp:TextBox>

                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="field message form-group">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="Msg_TextBox" ForeColor="Red" ValidationGroup="1"></asp:RequiredFieldValidator>
                                            <asp:TextBox ID="Msg_TextBox" CssClass="form-control" runat="server" placeholder="Message" TextMode="MultiLine"></asp:TextBox>

                                        </div>
                                        <asp:Button ID="Mail_Button" Enabled="false" runat="server" Text="Send message" CssClass="btn btn-theme pull-left" OnClick="Mail_Button_Click" ValidationGroup="1" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- ./span12 -->
                </div>
            </div>
        </section>

        <!-- section: Maps -->
        <section>
            <div id="map-canvas" class="embed-responsive-item"></div>
        </section>

        <footer>
            <div class="container">
                <div class="row">
                    <div class="span6 offset3">
                        <ul class="social-networks">
                            <li><a href="https://facebook.com/loopsit/" target="_blank"><i class="icon-circled icon-bgdark icon-facebook icon-2x"></i></a></li>
                            <li><a href="https://twitter.com/loops_IT" target="_blank"><i class="icon-circled icon-bgdark icon-twitter icon-2x"></i></a></li>
                            <li><a href="https://youtube.com/channel/UCQSWJ82cfVICSe80Xcvuz3w" target="_blank"><i class="icon-circled icon-bgdark icon-youtube icon-2x"></i></a></li>
                            <li><a href="https://linkedin.com/company/loops-it" target="_blank"><i class="icon-circled icon-bgdark icon-linkedin icon-2x"></i></a></li>
                        </ul>

                        <div class="copyright">
                            &copy; Loops IT (2015 - <span id="CurrentYear"></span>) All rights reserved.
                        </div>
                    </div>
                </div>
                <a href="https://basis.org.bd/index.php/site/memberProfile/1636" target="_blank">
                    <img src="CSS/Image/basisMember.jpg" style="width: 160px" />
                </a>
            </div>
            <!-- ./container -->
        </footer>

        <a href="#" class="scrollup"><i class="icon-angle-up icon-square icon-bgdark icon-2x"></i></a>

    <script src="Home/js/jquery.js"></script>
        <script src="Home/js/animate.js"></script>
        <script src="Home/js/bootstrap.min.js"></script>
        <script src="Home/js/custom.js"></script>
        <script src="Home/js/inview.js"></script>
        <script src="Home/js/isotope.js"></script>
        <script src="Home/js/jquery-hover-effect.js"></script>
        <script src="Home/js/jquery.flexslider.js"></script>
       
        <script src="Home/js/jquery.nav.js"></script>
        <script src="Home/js/jquery.prettyPhoto.js"></script>


        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdSl9Pfp6ey5lrsgNGUmU2hB2zrcmJHtI"></script>
        <script type="text/javascript">
            $(function () {
                $("#CurrentYear").text((new Date).getFullYear());

                jQuery('a[href^=\\#]').on('click', function (event) {
                    event.preventDefault();
                    jQuery('html,body').animate({ scrollTop: jQuery(this.hash).offset().top - 100 }, 1000);
                });
            });

            google.maps.visualRefresh = true;

            var map;
            function initialize() {
                var geocoder = new google.maps.Geocoder();
                var address = $('#map-input').text(); /* change the map-input to your address */
                var mapOptions = {
                    zoom: 15,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

                if (geocoder) {
                    geocoder.geocode({ 'address': address }, function (results, status) {
                        if (status == google.maps.GeocoderStatus.OK) {
                            if (status != google.maps.GeocoderStatus.ZERO_RESULTS) {
                                map.setCenter(results[0].geometry.location);

                                var infowindow = new google.maps.InfoWindow(
                                    {
                                        content: address,
                                        map: map,
                                        position: results[0].geometry.location,
                                    });

                                var marker = new google.maps.Marker({
                                    position: results[0].geometry.location,
                                    map: map,
                                    title: address
                                });

                            } else {
                                alert("No results found");
                            }
                        }
                    });
                }
            }
            google.maps.event.addDomListener(window, 'load', initialize);
        </script>
    </form>
</body>
</html>
